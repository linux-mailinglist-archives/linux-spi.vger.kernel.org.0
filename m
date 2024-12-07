Return-Path: <linux-spi+bounces-5946-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E07CA9E7DBA
	for <lists+linux-spi@lfdr.de>; Sat,  7 Dec 2024 02:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69E316D0D5
	for <lists+linux-spi@lfdr.de>; Sat,  7 Dec 2024 01:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516EF4C7C;
	Sat,  7 Dec 2024 01:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL8xitGn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF151BF24;
	Sat,  7 Dec 2024 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733534983; cv=none; b=QQuhxVwxrw/O23/m7NOnqGcjxmmND5XxW/sA/i9GyUdHyu9SU3fWdvYMNtwwkq6OSSR6bjNYR+AoZhlyPln5DgHqTmWxjpyi6PFpMNIPNwi92ltTi3Mffc7XWuqB3pnjtK1zNmFK1yZ2PI9S5qLvfuNulpE/UjMPRsSDHsBjELA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733534983; c=relaxed/simple;
	bh=pf2BxcyY1+GxOIa+dmB0408E08YUlmbwGhO92jMegAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YuT0yj9e/4BzhR02tgpqCpDunqRUFFFohKoH3cIgGhRDHOh35osaXshB2+0rSpLN8rq3LkCoMYdY69AY/XPqtlM1AzCBBIX5BPCRzKGLytVJ0OQm4edvmsOIHtn9j8NqzpVQxU8EDAnLZ/WfS5wLy1j/u5GxBdXLftgFJqp+JVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL8xitGn; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4668f208f10so25561261cf.3;
        Fri, 06 Dec 2024 17:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733534980; x=1734139780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RH3o/9bbeFcVlZkIN5EOi+1jWB15nl+IjEgrvkeWavI=;
        b=BL8xitGn8Qloe5gE+758fCwzJEhftsqQqJihsNRr3LgYokjiJZsZF+BmGrRZ5+znAI
         Gw5De5f4GCq4iaUooA9dhxXfjHwauK5lI3gbAuouuKgV0/bqxj12vY5zbyMosAFII2ux
         +/OmSohmPK7LoE7YWFY214XOJml0xpaqRAYR+4jbiVcUrW+9AQq3oWR5XHLTHLuDjFRJ
         3utCMMfexuegc6G9Osf0W5UOIusH7KPDgldw7ZtEd8+XuOI+4tOc42+7eBiPl92qDwQo
         tezggn+PhwVYjcpUdKkbHz/ff1klD8VVYwaQ7hh8Q3B7d9mlV0zSaLfi/vEOEXnCdCXx
         r22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733534980; x=1734139780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RH3o/9bbeFcVlZkIN5EOi+1jWB15nl+IjEgrvkeWavI=;
        b=DLl2791Hntwi+4FUzUNm3nK7Kc+1EX1BxB3nWFsgXK8e2GLJTI8uM18xeaSi1CA0SY
         ZlRTXMBeaqH5MB9VC4qS1PvHVtjQ5LvhLzDGU4hkMY7KVwNTpxuPkCvF9a2lcDEMH88o
         qH/x+mdtky4ZcNLZpOTolslUCl1rDb5H8eEGLfBrF8wgXKoN5MfCM5HJjFxFRBidHXTe
         R9tWaipqL+zOSqt6cNiWcuxYumA5MIBsPvHT/Mbdjb0oHaEJERmPVr21HQnYZ++hE0oR
         VQi/rLux1g4tHpeUmuDnJmjl6pzX7aFSaDLDy1MUTb9EfFXVL6LHa8WFBlfj3/JrF95L
         M6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVXJk9VolorGR79fnPYhqVXOiMdqUqmNx2anyBldf/dWGkD7tNoTWMSzFjNxOkk88diLTyDBcEz1O+CxQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysqIG+PLbUJ5C5vwwuoSGeHqgORTK+AUFkERvC6JVPHisabQYQ
	4+3zUV9U9ttO3UQdznQsLSED1s1zrQTengtXCsMuc0cNfs3g7kHE
X-Gm-Gg: ASbGncsXNAiCz2rptaU55S4Zdcla1JcIVVP8yNVv1WfEFuI18ADr53QR7/dyRdiFn4d
	VlaCYuTMtRBYa+AESn1OgYk5eW2MGSEdwWwBCbskwa+bj1HE/58TIL2NXkKGxjaKDHnXTmYCcJh
	G17+JNMX07/La/DEygRKwoO51i57T3wTxab0Y2LrGWUzgEnZHfL+PXLtBakRHkYhALKLUpzhmjx
	bT1+6uF6d6cd3Eoff0rZSuVyg+SXgSlwExpQEZ8Eap6noUoRSrwt5uwUiRpaQ==
X-Google-Smtp-Source: AGHT+IHryNFp2D/1XDHNwPuVlv5N6khcikGDnn64EfjaaFrKAlmCc89G8uNfZpWRrcmN/09WPQHi+w==
X-Received: by 2002:a05:622a:22a9:b0:466:ac03:a714 with SMTP id d75a77b69052e-46734db8b01mr93986971cf.36.1733534980510;
        Fri, 06 Dec 2024 17:29:40 -0800 (PST)
Received: from localhost.localdomain ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296cb98csm27101141cf.30.2024.12.06.17.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 17:29:39 -0800 (PST)
From: Mingwei Zheng <zmw12306@gmail.com>
To: broonie@kernel.org,
	michal.simek@amd.com,
	linus.walleij@linaro.org
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mingwei Zheng <zmw12306@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH] spi: zynq-qspi: Add check for clk_enable()
Date: Fri,  6 Dec 2024 20:32:58 -0500
Message-Id: <20241207013258.3615645-1-zmw12306@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add check for the return value of clk_enable() to catch the potential
error.

Fixes: c618a90dcaf3 ("spi: zynq-qspi: Drop GPIO header")
Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
 drivers/spi/spi-zynq-qspi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index dee9c339a35e..ae8a955bb6f1 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -379,12 +379,18 @@ static int zynq_qspi_setup_op(struct spi_device *spi)
 {
 	struct spi_controller *ctlr = spi->controller;
 	struct zynq_qspi *qspi = spi_controller_get_devdata(ctlr);
+	int ret;
 
 	if (ctlr->busy)
 		return -EBUSY;
 
-	clk_enable(qspi->refclk);
-	clk_enable(qspi->pclk);
+	ret = clk_enable(qspi->refclk);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(qspi->pclk);
+	if (ret)
+		return ret;
 	zynq_qspi_write(qspi, ZYNQ_QSPI_ENABLE_OFFSET,
 			ZYNQ_QSPI_ENABLE_ENABLE_MASK);
 
-- 
2.34.1


