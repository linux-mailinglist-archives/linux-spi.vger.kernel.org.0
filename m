Return-Path: <linux-spi+bounces-8624-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA12DADDA3E
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 19:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F181630D2
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 17:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A2419F424;
	Tue, 17 Jun 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ktswG+GO"
X-Original-To: linux-spi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F5539FD9;
	Tue, 17 Jun 2025 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750180099; cv=none; b=bN3fPw0eOvOjskpv/uR47FpCWLbarwzKVku5CnW7X/TETWjmz9AH3+ctFvTK3xs7gOMvd+ScR7Nxd3yv+r+ECsrixVFX2pqZhfOnCiJjTkELZVbYNMOYJ5sh3OGIoisq5p2uQ32JOIOoU1NWwC/NA97ib4l7IRmFX3yec0C+bYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750180099; c=relaxed/simple;
	bh=9UyZ0qdaeGy00gRF+j/wrolacZtIlCXXNyNgb7kJrIw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t+3bUnHQvKoA0r4VA+F9kbCxrwvHvFvZwWCA7XQULyaEOHsNqJHqQmzWrdk5QrjnqrJTkg9bs3qa8KDnJuHuuBGqTDiJ0S9iRIsaklhmiUc0aXcsZ9NESFFkvRuDK8aAaLkElKDAVXwFPPlKxRBPa+C8zZke1ReOK8Pl4qd36ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ktswG+GO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750180095;
	bh=9UyZ0qdaeGy00gRF+j/wrolacZtIlCXXNyNgb7kJrIw=;
	h=From:Subject:Date:To:Cc:From;
	b=ktswG+GOeIOYoasueGQUlhW+UxQrm0BD3sE0UvXQt8EIAh1bCLSC4GzRkigYLQX6H
	 pxm880rM+2J1AD21/1XJakFLjvWzwHCCI3JTLFuKCaZAsiZhxql9rsx6HUjUX/HrD8
	 gg5D6kUr8X79DkHUffpQdTAVBpMx/vnVL/Tw1avM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v7 0/3] locking/mutex: Mark devm_mutex_init() as
 __must_check
Date: Tue, 17 Jun 2025 19:08:11 +0200
Message-Id: <20250617-must_check-devm_mutex_init-v7-0-d9e449f4d224@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPugUWgC/33P3UrEMBAF4FdZcm0k/2m88j1ESpNMbZB2pWnjy
 tJ3d3ZFKlhCYODMxTc5V5JhTpDJ0+lKZigpp/OEwT6cSBi66Q1oipiJYEJxJjkd17y0YYDwTiO
 UsR3XBS5tmtJCQxd0I33smh4IAh8z9Olyx19eMQ8pL+f5636r8Nv2h8VRYwunnIJh4J31TbDi+
 RNSzjkM6/A4wUJudhG/nmaCqaonKKPWG2F5UN6COfTkX6+pehI9oTQobmMIDg49tXuK2aqnsK9
 urO8Q642Xh57ePXxVT6PnRN9hWSeDOf6f2T3DXNUz2NdpxaKOvbNM/fO2bfsGai28f1kCAAA=
X-Change-ID: 20241031-must_check-devm_mutex_init-cac583bda8fe
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Vicentiu Galanopulo <vicentiu.galanopulo@remote-tech.co.uk>, 
 Will Deacon <will@kernel.org>, Han Xu <han.xu@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Andrew Davis <afd@ti.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-leds@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750180094; l=1974;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=9UyZ0qdaeGy00gRF+j/wrolacZtIlCXXNyNgb7kJrIw=;
 b=dlvyC101vZs+nXCoUmIbNySmNr8nT+TeesQ8Mixx0XtQV21UErBjjo4urgDl7bM1gZ0h6Pemh
 TECmbDf8s8yAZhyLe8Z46N38gQQYj0UCkKTTlVi4+viArc0ivEI0bu7
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

devm_mutex_init() can fail. Make sure everybody checks the return value.
All patches should go through the mutex tree together.

It would be great if this could go in through a single tree at once.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v7:
- Pick up Ack from Andrew
- Reword commit messages
- Link to v6: https://lore.kernel.org/r/20250609-must_check-devm_mutex_init-v6-0-9540d5df9704@weissschuh.net

Changes in v6:
- Rebase on v6.16-rc1
- Pick up review tag from Bartosz
- Fix up spi-nxp-fspi
- Fix up leds-lp8860
- Link to v5: https://lore.kernel.org/r/20250505-must_check-devm_mutex_init-v5-1-92fa4b793c6e@weissschuh.net

Changes in v5:
- Pick up review tag from Andy
- Link to v4: https://lore.kernel.org/r/20250407-must_check-devm_mutex_init-v4-1-587bacc9f6b3@weissschuh.net

Changes in v4:
- Drop already applied leds-1202 driver patch
- Rebase on v6.15-rc1
- Link to v3: https://lore.kernel.org/r/20250208-must_check-devm_mutex_init-v3-0-245e417dcc9e@weissschuh.net

Changes in v3:
- Introduce and use helper macro __mutex_init_ret()
- Link to v2: https://lore.kernel.org/r/20250204-must_check-devm_mutex_init-v2-0-7b6271c4b7e6@weissschuh.net

Changes in v2:
- Rebase on 6.14-rc1
- Fix up leds-1202 driver
- Link to v1: https://lore.kernel.org/r/20241202-must_check-devm_mutex_init-v1-1-e60eb97b8c72@weissschuh.net

---
Thomas Weißschuh (3):
      spi: spi-nxp-fspi: check return value of devm_mutex_init()
      leds: lp8860: Check return value of devm_mutex_init()
      locking/mutex: Mark devm_mutex_init() as __must_check

 drivers/leds/leds-lp8860.c |  4 +++-
 drivers/spi/spi-nxp-fspi.c |  4 +++-
 include/linux/mutex.h      | 11 +++++++----
 3 files changed, 13 insertions(+), 6 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20241031-must_check-devm_mutex_init-cac583bda8fe

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


