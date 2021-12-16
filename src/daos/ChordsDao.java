package daos;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import constants.GlobalConstant;
import models.Chords;
import util.DBConnectionUtil;

public class ChordsDao extends AbstractDAO {
	public List<Chords> getItems() {
		con = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM chords ORDER BY name ASC";
		List<Chords> listItems = new ArrayList<>();
		try {
			st = con.createStatement();
			rs = st.executeQuery(sql);
			while(rs.next()) {
				Chords item = new Chords(rs.getInt("id"), rs.getString("name"), rs.getString("picture"));
				listItems.add(item);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, st, con);
		}
		return listItems;
	}
	
	public int addItem(Chords item) {
		int result = 0;
		con = DBConnectionUtil.getConnection();
		String sql = "INSERT INTO chords (name, picture) VALUES (?, ?)";
		try {
			pst = con.prepareStatement(sql);
			pst.setString(1, item.getName());
			pst.setString(2, item.getPicture());
			pst.executeUpdate();
			String sqlResult = "SELECT id FROM chords ORDER BY id DESC LIMIT 1";
			st = con.createStatement();
			rs = st.executeQuery(sqlResult);
			if (rs.next()) {
				result = rs.getInt("id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, con);
		}
		return result;
	}
	
	
	public int delItem(int chordsId) {
		int result = 0;
		con = DBConnectionUtil.getConnection();
		String sql = "DELETE FROM chords WHERE ID = ?";
		try {
			pst = con.prepareStatement(sql);
			pst.setInt(1, chordsId);
			pst.executeUpdate();
			result = chordsId;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, con);
		}
		return result;
	}
	public int editItem(Chords item) {
		int result = 0;
		con = DBConnectionUtil.getConnection();
		String sql = "UPDATE chords SET name = ?, picture = ? WHERE id = ?";
		try {
			pst = con.prepareStatement(sql);
			pst.setString(1, item.getName());
			pst.setString(2, item.getPicture());
			pst.setInt(3, item.getId());
			result = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(pst, con);
		}
		return result;
	}
	
	public Chords getItem(int chordsId) {
		con = DBConnectionUtil.getConnection();
		Chords item = null;
		String sql = "SELECT * FROM chords WHERE id = ?";
		try {
			pst = con.prepareStatement(sql);
			pst.setInt(1, chordsId);
			rs = pst.executeQuery();
			if (rs.next()) {
				item = new Chords(rs.getInt("id"), rs.getString("name"), rs.getString("picture"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, con);
		}
		return item;
	}
	
	public int numberOfItems() {
		con = DBConnectionUtil.getConnection();
		String sql = "SELECT COUNT(*) AS count FROM chords";
		try {
			st = con.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				int count = rs.getInt("count");
				return count;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, st, con);
		}
		return 0;
	}
	
	public List<Chords> getItemPagination(int offset) {
		con = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM chords ORDER BY name ASC LIMIT ?, ?";
		List<Chords> listItems = new ArrayList<>();
		try {
			pst = con.prepareStatement(sql);
			pst.setInt(1, offset);
			pst.setInt(2, GlobalConstant.NUMBER_PER_PAGE);
			rs = pst.executeQuery();
			while (rs.next()) {
				Chords ObjItem = new Chords(rs.getInt("id"), rs.getString("name"), rs.getString("picture"));
				listItems.add(ObjItem);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, pst, con);
		}
		return listItems;
	}
	
	public List<Chords> getItems(String name) {
		con = DBConnectionUtil.getConnection();
		String sql = "SELECT * FROM chords WHERE (name LIKE ?) ORDER BY name ASC";
		List<Chords> listItems = new ArrayList<>();
		try {
			st = con.createStatement();
			rs = st.executeQuery(sql);
			while(rs.next()) {
				Chords item = new Chords(rs.getInt("id"), rs.getString("name"), rs.getString("picture"));
				listItems.add(item);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DBConnectionUtil.close(rs, st, con);
		}
		return listItems;
	}
}
