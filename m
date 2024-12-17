Return-Path: <linux-spi+bounces-6065-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF249F4528
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 08:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB646169EED
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE9617A58C;
	Tue, 17 Dec 2024 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JlB3dIW+"
X-Original-To: linux-spi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A9A15B0EE;
	Tue, 17 Dec 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420726; cv=none; b=tugUwsAuPSKwTWCfeSUi+1Z4PIa6jNNuD6ELfmemyyRXTj87ElRfH+rgwWaV13S8YQBNdrDyp0gDeba3ZPjbewXd9DuXb+l6NvoKviCovQLzbr9uRV+aizHaOIj6Thdk/u6XLFyK9zrsD7ZFWI0/zPtwxZ+dS2xytJx8oMlIKYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420726; c=relaxed/simple;
	bh=J/xxn//Qm+RozpXZk+Z8UjqyMjIaFfwCSJTuh4OLR6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t0UsDp3WYT9JoIfDBdoe9GghT0zVhJCtgMg0jGZxKEbYoL0zJPiYU352NDZ8lF1EMYX9JB6za65T1WvCHaE9yLRGuIu+Zj1iSqG3PHQB80tKMLAuNSGJ2U6C+2DTHHg0yaKMFHiGKJVjgl9lfIcu97g/97aJKh1/6mOII4GTCd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JlB3dIW+; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=QNcGf
	gASXiwUkT0sXAhHlcJlf5pLc4GvYuZ2YvQKUUQ=; b=JlB3dIW+CUzBh3BNTfiVD
	6uLvgRQpbo1/rY82EAFXOgxjtuDXbgdV1jAw0pMQskUHDZbD5dwYINWXhKCXg6ve
	RZfIA91JHYjZKq7BkoVBFGYAKja+x5Igwj6MHX1WFLXWROybQrEpjmMK0fA8ds7z
	hFoR/oh2H7vJaOK6DkSTfU=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDn1xrWKGFn1RR_BA--.21494S4;
	Tue, 17 Dec 2024 15:31:41 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: broonie@kernel.org,
	aaro.koskinen@nokia.com
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] spi: fix reference leak in spi_register_controller()
Date: Tue, 17 Dec 2024 15:31:33 +0800
Message-Id: <20241217073133.2908052-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn1xrWKGFn1RR_BA--.21494S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF13GrWUGF4kurWDCF4fAFb_yoWkZFbEkF
	429r1UWr4DC397Ar9xKr4rZFy09Fs2gFySya1DtF4rtayrXr9rXr18XrW5Zry5Aw47urnr
	Zw17trsYkr13CjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRWGQhUUUUUU==
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbizR+4C2dhIXyjCQAAsQ

Once device_add() failed, we should call put_device() to decrement
reference count for cleanup. Or it could cause memory leak.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: f9981d4f50b4 ("spi: spi_register_controller(): free bus id on error paths")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/spi/spi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index ff1add2ecb91..6477c2f4ae82 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3339,8 +3339,10 @@ int spi_register_controller(struct spi_controller *ctlr)
 		ctlr->last_cs[idx] = SPI_INVALID_CS;
 
 	status = device_add(&ctlr->dev);
-	if (status < 0)
+	if (status < 0) {
+		put_device(&ctlr->dev);
 		goto free_bus_id;
+	}
 	dev_dbg(dev, "registered %s %s\n",
 			spi_controller_is_target(ctlr) ? "target" : "host",
 			dev_name(&ctlr->dev));
@@ -3356,6 +3358,7 @@ int spi_register_controller(struct spi_controller *ctlr)
 		status = spi_controller_initialize_queue(ctlr);
 		if (status) {
 			device_del(&ctlr->dev);
+			put_device(&ctlr->dev);
 			goto free_bus_id;
 		}
 	}
-- 
2.25.1


