Return-Path: <linux-spi+bounces-5948-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 060A89E7DCF
	for <lists+linux-spi@lfdr.de>; Sat,  7 Dec 2024 02:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B09E2847C9
	for <lists+linux-spi@lfdr.de>; Sat,  7 Dec 2024 01:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE56EC2C9;
	Sat,  7 Dec 2024 01:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoQ0y+6W"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002022C6C2;
	Sat,  7 Dec 2024 01:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536130; cv=none; b=b8Yq8eC3bITQWCTAs2uPgOksi4NGEh9A4RUJeTaN/2MVrEZF4WzC3wOPzcd79OiQiwfKQMhekzvuDnWNU4JkxYZrLypvk/uvLkUa887tBZrT9eyir2vZ6qSs1zKNUoqkzmHtsCrj835DMau+MC8j4nBrlw4EoRzrhRPPhJlmFSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536130; c=relaxed/simple;
	bh=jlW7i0i1xxdiIzCTmV5BNdwwj6plJBb52kQYU4D0tgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HyqWk+fgikSNCdcAx+W+bRontVxjWqKM5T+HR9A9yvCLw0+Lj8vd4iPSPpy/Pib394EqgrWKgdmqLYhFZvwtw7on06Df1aosNan73dh/A4ik8s0C+GVmMOo7R7UKSL1Xu9nkKqXSCl1u2VSdiz/S0e3ogCO/Yi0+DpcGz0KyvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoQ0y+6W; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4674f142846so313191cf.2;
        Fri, 06 Dec 2024 17:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733536128; x=1734140928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ajfi+wkQFyaWasmE+q4KW/J7MFmGlCQy0rOceUXZD+Q=;
        b=JoQ0y+6WQpPPDk5fnlXCXo6kaC5yVy6t22we7LFU6I0qYL2Q84qh97Jiv5na/DYtvD
         Qawu09Y3GZPaiyfmhjOLKqoRz7reuhgAgcQYryxZQQt9pIstvNPh+FXN4tb1etRTYwYL
         WkPbQdo5Pkg3sYVi+BEC2C9ajF0cd6lWW83dMPAHCJuARWDkRqc48j2dyVHmsaPHdVns
         JKjeqXGg+GW8c5B63sDZWKhLdeeF645TtrVx0wmSKZZ81salOM3YTk5wzq0vhtdapgEm
         43COA8Oskap++GHEKYBxskZM2dbPEBqNbPUVkTIx6LY1cfP0RXfgtwwhn2qQBM9OzziD
         KXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733536128; x=1734140928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajfi+wkQFyaWasmE+q4KW/J7MFmGlCQy0rOceUXZD+Q=;
        b=fLC2Xb9BnbgPSobe79BAKDLHBItK2K1FfrJUe0wHoZcE2VlCcMM/3Bsj7P1ze91ZXq
         Ub74vFVyP/cdROV1dZLSUvz0i7J/pPvIBaQyDNPTgP6n/KGmCQ/XtumJ6Jkpu1LJ1yMV
         mULxPh5ikjdk9ilZER1BJ/saexwPvi2IvxxSL4DujgtThauQlCfsaWK15GVO8s9kzelB
         GCX+hmJCwROUSwk2ZUVAkzwnPRUWyV60IKNqkhwNB5XIW/mftgK/meBEjIP9rVcDWPzd
         z/75nzL07il9AeUD+g/QoyCrTw1d9Ezp2s7QTE5B8mz53sUkUOeLQwV5NJOg8HNvmnTr
         b1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWWwd6iCwQBm/2tD/Hjs+S/BptwUxp4VJHLPxQ7rjLGvlqLijVX/hX6ASFc6zC/u9dP2hO5g4Hds0wbRVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzykIZ98mUmf/AVocnYCN8QchSzTkoDcky7mvTvqY362qyV2GDY
	7LFK3faCoXO2FIhM2xHPy5s9jOeWrQyO2fQyfa5RY2RhZeIE8IwZ
X-Gm-Gg: ASbGncvFr+iZ5gePJgciBT6TShRPbQbMToWV9NFkI+01ikL9igdlCsSaTVsT6bbggOo
	U0EPci9RweF9OFEiowx3cAGDAy6MztxkbDtt4+XiTqA58+Trm9I3LyMrurIZJ/0sSFS/y5Ry5Kj
	swiRG+CqBwK+g1tD/X0uXZTJIsteiGe3m0/3yywui5CC2o1Kbh4qVgNaH/fctX8mCT7KDT4kgz3
	5YXlqjJKH7GmyIgqhLax9wtgrXaLGtXVvEwZc5zplkrwuFI0o8ksBGih1PTHQ==
X-Google-Smtp-Source: AGHT+IE4NLqq67Nz90hVIj+QuOGnN+1RySBoeoLm48wEmZGUAS+YgYXJAD6JG1I0V+XjWUCLcketbg==
X-Received: by 2002:a05:622a:8e16:b0:467:4c21:e396 with SMTP id d75a77b69052e-4674c2206cdmr11685731cf.55.1733536128078;
        Fri, 06 Dec 2024 17:48:48 -0800 (PST)
Received: from localhost.localdomain ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6b5a84506sm228443185a.81.2024.12.06.17.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 17:48:46 -0800 (PST)
From: Mingwei Zheng <zmw12306@gmail.com>
To: broonie@kernel.org,
	michal.simek@amd.com,
	linus.walleij@linaro.org
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mingwei Zheng <zmw12306@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: [PATCH v2] spi: zynq-qspi: Add check for clk_enable()
Date: Fri,  6 Dec 2024 20:52:06 -0500
Message-Id: <20241207015206.3689364-1-zmw12306@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add check for the return value of clk_enable() to catch the potential
error.

Fixes: c618a90dcaf3 ("spi: zynq-qspi: Drop GPIO header")
Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v1 -> v2:

1. Add clk_disable in error handling.
---
 drivers/spi/spi-zynq-qspi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index dee9c339a35e..da6c2800d6b5 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -379,12 +379,21 @@ static int zynq_qspi_setup_op(struct spi_device *spi)
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
+	if (ret) {
+		clk_disable(qspi->refclk);
+		return ret;
+	}
+
 	zynq_qspi_write(qspi, ZYNQ_QSPI_ENABLE_OFFSET,
 			ZYNQ_QSPI_ENABLE_ENABLE_MASK);
 
-- 
2.34.1


