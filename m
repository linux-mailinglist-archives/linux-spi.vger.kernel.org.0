Return-Path: <linux-spi+bounces-3901-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6805193524F
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 22:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0F31C21AF9
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 20:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC85145A0E;
	Thu, 18 Jul 2024 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ahbcn1g4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB22669D31;
	Thu, 18 Jul 2024 20:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721333153; cv=none; b=QpnXOEsV9jDpWUZ56hw99ctxxTzKproG9dKVbh0cBuqKrSDNzEoQ6xvFmD9HN/XD1JBYf0WeHoD/8SCIWCPWcwGM5Pth+7R8FwWGNpaN37RanzwHvlHJs4m6/aMuzk20VkfMbnfc+s1EuHnGBaPdnvEu+W1TGKiQKIcd+f6U8dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721333153; c=relaxed/simple;
	bh=EuGFeLgn+jyO1NSVPim1hmbHweThsEK23Ff72ZwcXcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Civ4xnlFkU7468fDH6o+vHerY7bLLcTmTWSDPp5O34cjw+A9Fq+SMDvvbevN1ifMWWu8x0UuqYbnNFwSlEl+upIScnP3itdEnKIn/RWsLYtu89O1hFixkeexBWfkMniyV6tKMz35zi3VXrE9ZAEqXl/Q+LSaMg5pucEwO8qmZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ahbcn1g4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc4b03fca0so1131625ad.3;
        Thu, 18 Jul 2024 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721333151; x=1721937951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCUeWfTYXcd89Nebwtk5iY6NopsRqRRFJongsyDR3QU=;
        b=Ahbcn1g4yBJy8HpcOYaiGLS1Q7uVN8UGJGi+xsLK34/41lvHrBs8Ot/Q3AClQGvP5y
         +cUUHXg3f7N3uMkEv6ji8xEQRfnpxLo0N+zX3VWld4WEQVkRydxkODye3+mra7FVi6Hj
         Eca25vOt634dD3oxb4rwCTikv6xW89QM4KfdW1EBXbNje73ysZmAQsQCwycsEGr8ZbVC
         9oGw32817HKdHdsFW3FUdxrwrewiC8iba+ALn1oXH/lPx8Lp0H03BwCU7LuIlFnSbykT
         rybfXkwDmYIs/9oAO1A/XCmizVR33CmqE03bdlmOmg9bb10BfFhfSGsMVqesAm/L2T0m
         /ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721333151; x=1721937951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCUeWfTYXcd89Nebwtk5iY6NopsRqRRFJongsyDR3QU=;
        b=k+a6aLOEZ/bjuhcYnfNdc0ax7sfCjgp6E/rscWgDJTe8L4z6nR4oJJREO+lpQWWMiF
         TRmHo5U63jiiGqJ+m4neQJxfBU21b10OW94Upa7C3OhIQEkLlQds5gmgjXBCMiUnd9du
         9oLyjphg8eom8c7v62lFIQLwjk9afiP60HbRaVk5ZoknXfaa0cG9cgCNC9ry9uzN5CRB
         +bRN/VFC2kBgQS0sFixs6T2cQLZfJ/YXf4pSMCPUf8+7Jh0ENG7LMVggJMcb37rxfagy
         qFQcMKZJdj0F6tvUuRsE+2fsqW74ygjk/Om/M8Lftbhdir4IdX4/xrt6FMdhmMVXaep4
         bSHw==
X-Forwarded-Encrypted: i=1; AJvYcCVy2LXqwvZTifhyfMU0kdzlkMXe+GztewpgxDFRxoh7ms7g0EnkY07TGZWi10jk7jZDNhlsZUZ6xHWJcwBFZC8vSE/1x0MRXcWurQ==
X-Gm-Message-State: AOJu0YyAB/IaKvjjZQn51HnrSF3bxNvOIunEKYnH4ZaKN4usYxmd7rxo
	Tsg2L55E+BpZMxShaV/b4YAOQGZ5p+Apn8vCMDT2z+NWYKW/ApnXsj6/aw==
X-Google-Smtp-Source: AGHT+IGvDSTNe79yH2dsg4k7UaByz15AEFPgV5CBCPzblt6KspaHKgyyJcaHdPMCHnusBi9Iy9X25A==
X-Received: by 2002:a17:902:e74e:b0:1f3:10e8:1e0 with SMTP id d9443c01a7336-1fd5ec5b9b6mr4718395ad.2.1721333151055;
        Thu, 18 Jul 2024 13:05:51 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bc92:63f4:6f0e:1985])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb74145sm97350135ad.3.2024.07.18.13.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:05:50 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	otavio.salvador@ossystems.com.br,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/3] spi: spidev: Add an entry for "elgin,spi-lcd"
Date: Thu, 18 Jul 2024 17:05:39 -0300
Message-Id: <20240718200540.955370-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718200540.955370-1-festevam@gmail.com>
References: <20240718200540.955370-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.

Add the "elgin,spi-lcd" compatible string.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 05e6d007f9a7..316ed3664cb2 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -730,6 +730,7 @@ static int spidev_of_check(struct device *dev)
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
+	{ .compatible = "elgin,spi-lcd", .data = &spidev_of_check },
 	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
-- 
2.34.1


