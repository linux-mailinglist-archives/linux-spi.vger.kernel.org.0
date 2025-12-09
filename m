Return-Path: <linux-spi+bounces-11834-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E51CAFCFF
	for <lists+linux-spi@lfdr.de>; Tue, 09 Dec 2025 12:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E8623107763
	for <lists+linux-spi@lfdr.de>; Tue,  9 Dec 2025 11:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0D82F39AD;
	Tue,  9 Dec 2025 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gI0xScNe"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D22FD1D7
	for <linux-spi@vger.kernel.org>; Tue,  9 Dec 2025 11:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765280506; cv=none; b=Rk+KJWXgNIX3ym6+bf97UbBFsfb3oxG4Li/e3P7f25GpPRn+VkhvtNmmvfWf447FYWOw5xwlERmg9Ul25ho6EiNFPCoIpexw1FF9GZcbctFmsvHdI9LZ8tPhTCwctQ8TWS09Oerfq13m0EmsZJgCX2IjVF8r4rGd57KTlbtR6no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765280506; c=relaxed/simple;
	bh=06BdsgBVMEqXdfbdXIticJ66myk41PEFHYio8i5FOnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBIU7wft2qR+CdlJ2/1pfiS9RuWaIcowJ8lhYZtAqCN4oFr34GLoBaJtJgouJZYdFjbL2U65SUgAzyfMjtGpMxQ2cK5Q2TmWT4rSwCJscKspNfnfRzKobBfgN/hKSdoev1k8E4Acvuvj3eMWxWMGseWcr+tpa5Bb6VSEekJBJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gI0xScNe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779a637712so40938785e9.1
        for <linux-spi@vger.kernel.org>; Tue, 09 Dec 2025 03:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765280503; x=1765885303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhL9+AU6HoZyZQmOa4BOGYYt3eA+LGP7dYShjppdZks=;
        b=gI0xScNefQwHSYCklFqHP+ib1e2C/jj3qNX2VeSotkMt7jedoq1SDcj+UCaZkM1NJ7
         9khl67qGjw8xJNV/Z+wbC1uUW0WrByVDAktkDtK/2V46Eygae5Zo3WvsAwN7oG3oJAok
         fqazVJ1NmjIozZ6HSZW2/dKFkOw93tKM7Uyu1XcIYfgKcaJvsuqLtGfIqtZA/rwehdz5
         avzdhZEcOuQXj2o19Qtkbr7Bod13DFJQeQWYLk9WKijofKoKESLRVpHnqhGvGE/2eXof
         jfWEL2K1Dla6UKIfJTkxBSnkhNYSg/PU5nR9xCz7I17dyEWvO+XDkqU1LX4lbAqP8dij
         N9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765280503; x=1765885303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rhL9+AU6HoZyZQmOa4BOGYYt3eA+LGP7dYShjppdZks=;
        b=Ij98ps51REkZFFU31/V9fhW0sOgM/fKTpJ6ytITkaTniRtvFSi9V9LF5hf1WBw7Cz0
         bx7S6oF19RYkZNlqcKN+CEa7v/1yk8PpoSWw7Biqvz4Rry6PSFvGjsUVA8wib4b8Y+QD
         Y5ilk5mEq32iFWeF0+y9uujc91+erHhT9WcjzxruTgd7GdJrsOt4TVrks34NO/bTxvd5
         YY0VQu3QC73h5BbPSrLmImQAXgaC6HPdDymjDbmJmEvUK+NDzvggYWnjNT+RB/6zpn/C
         CL9aryr5snkidIla18dW/IjctHN9ys+9NynIRGOxH9JuEBu5Py0wuwG0OCinVTNfAav7
         rhqg==
X-Forwarded-Encrypted: i=1; AJvYcCXTOeJfKdSDOkfpdtaGiCuxFboezy6Qi8TnHC4z72rIOyo5kEbVnnQdph6kfin7gstfqzJ9RtCjoYs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf10/C0T6lh5ZdCQ4YT71A1vPTPz8xo6I8Lhj+YGL87rI/V2SF
	2047vM6BkxpkgHYrdvuEHafh06LPal+zPXPtgwSbSLkiho6tP113EJh910MIb/LZhMY=
X-Gm-Gg: ASbGncvsHViZI8z1tlWPKnSfopfLqyatoUb/2oDZ/XuOlzp8MPZNLesKmFCeNEMIjcp
	AA5ApZEFKA8JcglMOIZbfHQI30+4J3jB8nnq+DYEn2l2NH632IWfdG1FEw9Nac0VPRkD9fMVz95
	MGNS2FQPNwxkJUj9j1Tp49b0ZWnvqwP/UJEazX376Bhc3/LnOvRYquD/zv6OpHNm7A2tIeI9eZb
	uCC5rWHqJc+nO0GdgFilsWWJQ+hWWV1XFZfxHYCi5RPp8osWTX+zQ9glpjPiXvNU4lwOEJWwdc8
	PNjpgPf0vJEI4S4yeZuJa7ymrVpXyo6iIhnhgjPLQn23t2QNz34ENpRv26AGpmZieMGg8Uf3s0g
	7upGtwyQTElE7x3ZuRpRsFExT3mhVIDTscn9pfDKDAz9EyeWQlSOSrTQxzqUIPhYIfaNJTIjaNa
	myE2spUBzvl8UFjH10fzDADxbL5Cs9bqjpgCalEDyTuIj0t2wx8h3HhKnZ0P3azITmdqJpyJdvD
	aI=
X-Google-Smtp-Source: AGHT+IGuRTUH7a39Dsyspi2QJ5C/0tpwri8+2mZFiVZoulK+TTvvMH+3GNzkr6TbOUOeSCmow+m4DA==
X-Received: by 2002:a05:6000:40df:b0:429:bc93:9d8a with SMTP id ffacd0b85a97d-42f89f476b3mr10441592f8f.37.1765280503200;
        Tue, 09 Dec 2025 03:41:43 -0800 (PST)
Received: from localhost (p200300f65f00660846b2ba6e435ad603.dip0.t-ipconnect.de. [2003:f6:5f00:6608:46b2:ba6e:435a:d603])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42f7d222506sm33270410f8f.28.2025.12.09.03.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 03:41:42 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Eddie James <eajames@linux.ibm.com>
Cc: Ninad Palsule <ninad@linux.ibm.com>,
	linux-fsi@lists.ozlabs.org,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/13] spi: fsi: Convert to fsi bus probe mechanism
Date: Tue,  9 Dec 2025 12:40:37 +0100
Message-ID:  <fc2a758ef00844dd5bd614a25b36a4a38355d12d.1765279318.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1765279318.git.u.kleine-koenig@baylibre.com>
References: <cover.1765279318.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1271; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=06BdsgBVMEqXdfbdXIticJ66myk41PEFHYio8i5FOnI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpOArVinCbj1VedreZCccuR2KxrKHV8acSr36wx R6jwNzck6KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaTgK1QAKCRCPgPtYfRL+ TjDDB/wIHTvw0hGof8gtMjpiFRj2jv4jZnXlhHmUy0svAJUTKRPPRUNtOEv7aMXxfzszw4kyOri TSJrnvvN1WHj6USRO44tb9zScZxt2GeBwlbdEyoYrTIG+5oJYdCxuSD/SyP3OHTtaKoGjqDwC88 6WHJJ2KI8rW1/HUttDvLNQnDyeuy+pz15iCazfvsU1PnmOgK1JX0gwi9qQiSnyNjIZ3L8vyu7Sp C1e54ReVtgkugjUzOXEpSsE7wYQEG9lCyLEdjrhp8WrQ0amSSzMZrG/af2BT6yRCEzEjWvB12Ub f99wL9YTrKYch+/wFMoyklysOXFQZSg1Al0A2Ll1WXideXUv
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The fsi bus got a dedicated probe function. Make use of that. This fixes
a runtime warning about the driver needing to be converted to the bus
probe method.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index f9c15b99dba5..07dc3d24f2c9 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -528,13 +528,13 @@ static size_t fsi_spi_max_transfer_size(struct spi_device *spi)
 	return SPI_FSI_MAX_RX_SIZE;
 }
 
-static int fsi_spi_probe(struct device *dev)
+static int fsi_spi_probe(struct fsi_device *fsi)
 {
 	int rc;
 	struct device_node *np;
 	int num_controllers_registered = 0;
 	struct fsi2spi *bridge;
-	struct fsi_device *fsi = to_fsi_dev(dev);
+	struct device *dev = &fsi->dev;
 
 	rc = fsi_spi_check_mux(fsi, dev);
 	if (rc)
@@ -593,9 +593,9 @@ MODULE_DEVICE_TABLE(fsi, fsi_spi_ids);
 
 static struct fsi_driver fsi_spi_driver = {
 	.id_table = fsi_spi_ids,
+	.probe = fsi_spi_probe,
 	.drv = {
 		.name = "spi-fsi",
-		.probe = fsi_spi_probe,
 	},
 };
 module_fsi_driver(fsi_spi_driver);
-- 
2.47.3


