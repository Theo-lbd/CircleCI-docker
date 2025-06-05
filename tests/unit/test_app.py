from page_tracker.app import app

def test_index():
    response = app.test_client().get('/')
    assert response.data == b"Hello from Docker!"
