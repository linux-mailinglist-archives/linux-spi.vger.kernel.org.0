Return-Path: <linux-spi+bounces-5253-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D190D9A3E4C
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2024 14:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85F961F219C9
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2024 12:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181DE1D79B2;
	Fri, 18 Oct 2024 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nIdlTye+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68734208AD
	for <linux-spi@vger.kernel.org>; Fri, 18 Oct 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254284; cv=none; b=XLLOatgmq9qyFr0KpY1CLXlwpNtlu7GD/tx37erwGRPjQ4uEsbQUTmSxRm5F62QNL3pPzfBf8ye9oQhgAiWS4W8WRdGwgs8ZghGE7Gpis4jdwtpeBNvdCAUuYulbIWbFdJ+EzpJqMv/5PFeTEP+cqRj1GvzNIP8KtVqYaKSJ5GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254284; c=relaxed/simple;
	bh=VHw/GBoW8BYLfS7z5ET9McRCyi78Nnx41JGN6LhxslM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5zyUYbSbXcgS1XEVXNOW8wn6/g43s4kvPMk4C/QUvDrB8D6Pw1GykfZTwUwV7hkMzVpgdf56kA9OzuXwbFFDnj4DMQ3VDmxnYzziyN4jIsBEZjkue+MeXhMyN6Ninu77jH8mkxlzq01M+g7OZQBOfW1fbIUx2Fu+nhePbb4/FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nIdlTye+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso11312145e9.1
        for <linux-spi@vger.kernel.org>; Fri, 18 Oct 2024 05:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729254280; x=1729859080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p5yAXKgkvRlmM7Q3Q1r6EA4WE06NJ9JBCqdIMCdrQfc=;
        b=nIdlTye+wmKEaDtKSbUHJ90FX4PsC0svsQb0LCAdciJTc+ALmyx9fFSEsti1buisY6
         l4PakiXEF1kWWjz2NxJUIefVXWj76sbajUcDA/Lio1i8Un3I3txvSd2NuadSpjvJSVPn
         Mza8WTw4Jvobjuz2+M+gV3UEv2/ByhgWFbb2ycu4j2KahEMxHJPP+oBUFBbl0CQZcRuF
         e8fulZiiOaFfia7VLXZsuvw1/sFkefQpVjIb/c2U53WidRZdJryGzV2Z1vFQxE2Bq4cl
         Q0JaZmyA84MORS9wp8Xmfil37CMwK3AczIt+z7I7CQyKEDzaA3XwWNEbaD+Yv9ajKTSC
         jd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729254280; x=1729859080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5yAXKgkvRlmM7Q3Q1r6EA4WE06NJ9JBCqdIMCdrQfc=;
        b=CZPnDuM8WRh27y/uD+1669wu21uWSAxDYuvqfmtN8kZMDFop92AO5WEOr/OtbiZPEX
         8+Nam5mh9PfQ8a7Z0eeOGWgDgwHArB0p+IEE+A45aYjEPkYZY/pS7bcRgfe3OkUK8Jul
         drOjAD26Ta0VQGhMFJ8R7RPkFPZuDwfq9QHl8NIC+MsVzfEVDDXKw+ll1h5b8dh6VSRE
         ZkYPuYk2+ot1Ex5ypXDRQBxgsgV1cHRb2iAkI/CAwbwdwqvow2uwRpkzQztafD2nMv3c
         x153IfCqkziduHBu9pOTnvSwd5kJrBIIhcBNAG3IoQABlS5SM9AUnRBqRJbddVr+IYLo
         2Zyg==
X-Gm-Message-State: AOJu0Yxu+rw0ex5Ox7n0wFgK1bgcHFvZ6ipXdyR67cTsT1wp/24Tc5Vs
	52qjJCq6qyALvoMs65OK21+e1sbhrTsHkbb9gKC1x2STIidVqPJ5zVbi4sn0jfEYskb/cVCUTdE
	9
X-Google-Smtp-Source: AGHT+IG2ngeX0J6avQw7IRzxx332+oMunIxQk+ee9sLmJVKDrk/IfXceSnQQ4Nx6MNAMfwxAOrNzWA==
X-Received: by 2002:a5d:67cd:0:b0:37d:5301:6edb with SMTP id ffacd0b85a97d-37eb48a778amr1382595f8f.57.1729254279803;
        Fri, 18 Oct 2024 05:24:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:45a3:93e:5196:d8ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf08a236sm1823351f8f.62.2024.10.18.05.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:24:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] spi: make class structs const
Date: Fri, 18 Oct 2024 14:24:37 +0200
Message-ID: <20241018122437.64275-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The two instances of struct class are only used here in functions that
take const pointers and so can too be made constant.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/spi/spi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7c5e76b15421..5528c46edd0e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2926,7 +2926,7 @@ static void spi_controller_release(struct device *dev)
 	kfree(ctlr);
 }
 
-static struct class spi_master_class = {
+static const struct class spi_master_class = {
 	.name		= "spi_master",
 	.dev_release	= spi_controller_release,
 	.dev_groups	= spi_master_groups,
@@ -3016,7 +3016,7 @@ static const struct attribute_group *spi_slave_groups[] = {
 	NULL,
 };
 
-static struct class spi_slave_class = {
+static const struct class spi_slave_class = {
 	.name		= "spi_slave",
 	.dev_release	= spi_controller_release,
 	.dev_groups	= spi_slave_groups,
-- 
2.43.0


