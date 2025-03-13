Return-Path: <linux-spi+bounces-7140-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B094A603AA
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 22:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 625F87A7C56
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 21:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251351F560E;
	Thu, 13 Mar 2025 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqG97IDz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A3C1EA7C9;
	Thu, 13 Mar 2025 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741902592; cv=none; b=nbQXVeSwdooa9elgNrCK3SD9WO2pnJpnCG/O7x6IjMNGa36nqLIQnY07HAPih8Q44JRMs8XeI0zlC+h3VRTKqtSU/rT8gIPrtO0MPyqYhNn2pnSyxtCXHZEKpJ6fw+kScLTjlL5PkL+OLg2fxLVgXOgGzt01BiYV/gNx4oAlQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741902592; c=relaxed/simple;
	bh=s6ZZPBgSNm+7Tbxr4xxDMwt/ylG47kRI0MABXLDAZRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nBOca9xIZKFD/Ebh0PlHeEPj22NgmjJBkqGsuJWbugc5jT7MOV34utOW9Nj/9WbO1yzbyuL/Qw9P9MGQbuVqSmDkTAelqryRGFqfUuFvvNF6B0kq9p9OOEKb/+VJ0nGYtUw+mHl4nGabxMFtoeR5kK9yNZyUfh7OmWOalcG8MSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqG97IDz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso13511295e9.3;
        Thu, 13 Mar 2025 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741902588; x=1742507388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a59t5p4Ssda8jFWgClkE2Iz19PPyQUZbqugYJx8T19A=;
        b=BqG97IDzCwo+1m1rz24KgDUItqKcpU+bnIS09mLBd5u4jJEVaasU7P/aGkE9Bd3dFA
         ukEIJkIBZHC/kOE/hDwHtJ5n6Lgv0agMvoACi3oeSsXc050SubYlUWdjX1tXU5liZBhW
         7sNKaR5C+U221OxwnIelPp4H0h8yXFSnMePYAtdckiEi9b9UUqCRslSaL3WFpGeIhfrE
         2ymDsCpl3q0BcZBWNm/g/GjQpmT91a6jqPVWGVZRk7B++VTzANmXZSylKDt/2hW+5XgY
         3QNBWzjYhI7pLweaUzdOA9dAh6PyjkVM7puzxBkDmCrEfZMtgIxvCAbINBevujI8f5B5
         fLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741902588; x=1742507388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a59t5p4Ssda8jFWgClkE2Iz19PPyQUZbqugYJx8T19A=;
        b=w5ZklRTh5yspYotNANPBVsl+Zxtlj450+LU3Qjl9AwxjNUVq0zk6iv3M+x9PInYt64
         7S5jO3LQWcjvcCnURQdYLY+N0y6Y33wEyZXPa88SL5D2vKpBgWGGJqhqVT5OOxooRj+4
         +1rO2KcqBAxbanlPpMdkUGX9cQ4HE9OGxummP9V+oUI0XxQwCFKLsZtgz7OPOHkqNpVr
         ZhkgCkFRNyOCFoG0Ye/gMbZvq93ZgflAIwenmPudcoM+zYAjEVWmQmJ+Rsziu9fXHCnc
         mjB4AZITDu0elHmy0H2BJ2MKD2oUx9HKT6MSX6BRuLFmN+ztc2xcjsURk1jf3ULLBiMz
         +B1w==
X-Forwarded-Encrypted: i=1; AJvYcCXd9jsPsgBgJrbZHVbuuxLIYgcqYxrPTEIWi9Nd2r+G12+KiWpoNsDqgplxjDMI3+GX9ie7bON/XLt2SG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpIGXq1d9FsC5J66wFikQ0uK5r83CfQis0q3TBljjqOxfZH0ES
	Qntv+3Z2xoPjVw7kHRvV6/acGLN0Q+tS410DrAGeXizB+4yvzJyh
X-Gm-Gg: ASbGncskodnPygRP5VFrvNDFdKB7YfGNDM3JE6X8IFTPIEe/ZCX3K/AniuNFlFUDtiB
	6r6Sdq5qh95ZHr+Jj1ljszQ6vQGeHJ9dAI1/EtjzK4IhXf/5BmpdJoRQpBViS8b1dU+0ODuZtLf
	WUz2+3Agi86hqXtNCzt3V3Fdysjm+dNUIDvkUzGX49wjEyXtb0trl/xkmdcCz6Z3LA5364KO3vH
	94Ilf2oCp8xy3cM9+61JVeaJ7+rNSbivI0TOwV+HuMmcr3GKY4hsp+StynwTK6h5bL9TXtyPePo
	pAIHndiDlpIiszmhJdrFQptBjoIWWmARzl4x/6lQ+E0R9LxsR43Ik6FrDw==
X-Google-Smtp-Source: AGHT+IHZvu3jRI8WQeMxTbEoEDws1DiHY2ifl3Vv+mDsE6UBOTt4rTvgF8i8qZsVjtG+V6o8Trwohw==
X-Received: by 2002:a05:600c:4e94:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-43d1ecff346mr1837285e9.25.1741902588406;
        Thu, 13 Mar 2025 14:49:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:6696:8300:f7f:aa2d:c9ce:6bac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a8d0c4csm64669865e9.38.2025.03.13.14.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 14:49:48 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: broonie@kernel.org,
	looong.bin@gmail.com
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: sophgo: fix incorrect type for ret in sg2044_spifmc_write()
Date: Thu, 13 Mar 2025 21:45:45 +0000
Message-Id: <20250313214545.7444-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sg2044_spifmc_write() function uses 'ret' of unsigned type 
size_t to capture return values from sg2044_spifmc_wait_xfer_size() 
and sg2044_spifmc_wait_int(). Since these functions may return 
negative error codes, using an unsigned type prevents proper 
error detection, as size_t cannot represent negative values. 

Change 'ret' to type int so that negative values are handled correctly.

Fixes: de16c322eefb ("spi: sophgo: add SG2044 SPI NOR controller driver")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/spi/spi-sg2044-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sg2044-nor.c b/drivers/spi/spi-sg2044-nor.c
index 454153a63b42..baa4cf677663 100644
--- a/drivers/spi/spi-sg2044-nor.c
+++ b/drivers/spi/spi-sg2044-nor.c
@@ -216,7 +216,7 @@ static ssize_t sg2044_spifmc_write(struct sg2044_spifmc *spifmc,
 	size_t xfer_size;
 	const u8 *dout = op->data.buf.out;
 	int i, offset;
-	size_t ret;
+	int ret;
 	u32 reg;
 
 	reg = sg2044_spifmc_init_reg(spifmc);
-- 
2.39.5


