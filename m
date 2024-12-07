Return-Path: <linux-spi+bounces-5947-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CCD9E7DCB
	for <lists+linux-spi@lfdr.de>; Sat,  7 Dec 2024 02:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0917616D25F
	for <lists+linux-spi@lfdr.de>; Sat,  7 Dec 2024 01:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5872C8FF;
	Sat,  7 Dec 2024 01:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntJmw7Mj"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA8F22C6FF;
	Sat,  7 Dec 2024 01:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733535854; cv=none; b=gQe+i1/aLTIgA6OjyxKlDC9U4fNU5cxg81FQrDtXItYIwbbx+XBUMfD8oC4QkrpjmlCkHl4JP/REesurLfVcLk1l9ddnLoPL8e/wee1b5MkVjjN7UfO4KygY1DpG1RJPaS6Mqr4aor8penbvQaLAtUlkgSmzoA1g1noDBfB0H9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733535854; c=relaxed/simple;
	bh=pf2BxcyY1+GxOIa+dmB0408E08YUlmbwGhO92jMegAE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KU+8B2zI2Gx9EgmcpW5sb8xgqETRbGkjzH2OGTy4CclmqbexDeOg2CvYScvklZjbEwDXxC2hGXGEKg7ReLs6QRXkROzMyQBJOs2p0vIR7/4LCME0ulXMOENPGstKWcF3o/ZRDXlAqG3Hw9K9wJnccn7XWYEHMMxmcN+ECcYfMAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntJmw7Mj; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46684744173so45856721cf.3;
        Fri, 06 Dec 2024 17:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733535852; x=1734140652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RH3o/9bbeFcVlZkIN5EOi+1jWB15nl+IjEgrvkeWavI=;
        b=ntJmw7MjDPX+1QC/eeFwuE2nzBQaXPB9ItLh+GqhHoIT66ZTt0gKVx6mhiXZj5Jl3X
         8aZwKqx+fAHErzoTAwB1ovhkNfU4eRTPY1W6/UoLYu4F+Sz6BFuvgstqEJjKrBg3gTlu
         v82/pwc+gBmrnOuxaWC+Oa4TOTCD+ShDkeE7F/iEUJXaBYtoHKAKmqjmgNAG0F9CQC7T
         5M0DMXr3FJoLj/EknlwX4iS0YKQXS6fYGEGyPGRe46zE3w+H08nkLEGRRD3ffkYFYtSk
         Vfk6nKY7WkkDYht4B38zWZL0H9wfjWDEy4QqjuAlbyY57LE/lQbd2lunWN5xh5liQq6y
         xkJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733535852; x=1734140652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RH3o/9bbeFcVlZkIN5EOi+1jWB15nl+IjEgrvkeWavI=;
        b=oyTa13mcfr1o8d8VPqtfWv7DIYXV1nvHUFww3ZbQ5l9va538alyxRdM4iSemE9EcLi
         T/bEMpADI223B1Dv1/dSjfzdKMtPxsJ11DYOXhJ3FenhV5xM93mZ3aUSxqO1LNcQzT8+
         eUldDTBpDOQfSpuwiTW3F3eu772LSDMFiB8q3KrKdmLAzecFFsihUAECdDoLFVUeDylQ
         nL4Rsd/TkkkzLjuGWdKGmO201Y6y3Fd4PZjMwERXABOzCIaxNSwqMP9jHI7O2hEiHigX
         NpUU8KCADrDpkO2PtwaNaqxlcSq3QxAk10MNn2ipzf6JGoAV6k4ANvpGXuvNywdDZnOL
         t+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVd9eY6mZXxj6PXdW1F8psaCHU4lF2V2Zv83uH+oY3zJkXAfL9670Y9Vv40AweV73piWNJHsaNMPEUHJ1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1S0S4wk+xbX6GCMiB6YxhwIGeOBjhQBseSpUKlYm5IKcZ9fP/
	UK6S9DrHQGShWwPN1WYIVP+hCkez9yloYPmW3UtIcJxLjJGc204o
X-Gm-Gg: ASbGnctOe3u/GY7N7k6AGH2MzkgJqMDSSeFzn/4niDbjbJzZUGfZJf1/YDg6m+PDC5J
	WnaHRwKIx761Qin9B38B7Xittqbo4zaT0iihktGc/v0JGbwvYMj/RHQr1SFu0yglbkqnkpdvAh1
	S3gUVhIkjfFR5nFX17HsslEtQIdc4vySn0sJIf/f77JUV/sdQKCN/IQ7PQuxZwaJTypET5r+FPt
	GyEB0yLabUuSLvKzVTztETOcB7BY3Wvo1wLj9ksue5E3fVxHFfsqGRhwPGScA==
X-Google-Smtp-Source: AGHT+IG6YJkMyzt9W5oYmdKcA/5vq6SQGz71FJsBh2LA6BlbgnUkH3jlw0cM3ZpckGM+ii/tksa9bg==
X-Received: by 2002:a05:620a:3950:b0:7b6:6756:eef5 with SMTP id af79cd13be357-7b6bcac26bamr913305585a.4.1733535852085;
        Fri, 06 Dec 2024 17:44:12 -0800 (PST)
Received: from localhost.localdomain ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a67561sm228923085a.64.2024.12.06.17.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 17:44:10 -0800 (PST)
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
Date: Fri,  6 Dec 2024 20:47:27 -0500
Message-Id: <20241207014727.3674388-1-zmw12306@gmail.com>
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


