Return-Path: <linux-spi+bounces-11470-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 647D6C7F486
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 08:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 442D74E3A68
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0662EA157;
	Mon, 24 Nov 2025 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wR7nhKof"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587772E7F14
	for <linux-spi@vger.kernel.org>; Mon, 24 Nov 2025 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970969; cv=none; b=AiDPaIIMeFAz+KPzyw4r5Udi8fc09hFJL9Ux//HbUAKTLZvp6SmmnPYQuVlrjx2xqFo/Lw6s8A7/FXcvISW80/M/Fs/l8/OOwdhotQvn5IHgybGOyn+r0JzWwNW0zzUmNxVwLcJJn8NaU7s3Wa+q3k1GFFo7itFaxhWU0vVMR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970969; c=relaxed/simple;
	bh=BAKV6mRJkamAvDuhdXunfVVuTbGwv1bU3qmP8zeCm1E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ti3pm5oEG/GU9oyBH5QmndfL1tyhgBAIxCQRBtl4r08t+1Ec/UFYYI0kTll09RZKIj1Dt2uT0GwswwezTRef4x8bmiDiesUzf7FgU5bW6AGBS2xqs5eruyVgsVsqgSBNqDhm8UwHKmpZdDc/mcg+8BkROf6sgo2/V2uagSEDwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wR7nhKof; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so25292205e9.0
        for <linux-spi@vger.kernel.org>; Sun, 23 Nov 2025 23:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763970966; x=1764575766; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jevOMx3oLEe1om5TMl1VbYUf8BPerVwJX0XKtmooeDg=;
        b=wR7nhKofia0h77DUmvKWBTI+xq/DPk1OKIyVcWAfZ4Aeil0ORm91MdT5w7XWAFUZeR
         S8Ha7Vv/TLGpz3iL62AcGxIAvcUnxYLNwIJdWUPwgNls2HqhyNCcRxZYkASQUi1u2PQj
         QeQpPGxoal7Hy+BozvdfYwj9fNlhySqiSWFIng4vgsIPtzanwVSPrUkAgLfd1uJH6j05
         WLyBTm+DcLJb2VhxaN085cUh3ITH3SJflRE+HUh1b0D35v1BIwY8MAwI7gJ5BUylg8jN
         HZPbtxh2BmQTsANg7YGH6WgKwyhK7xBhlLJgGsrGpnul0u7qQXAmeWM8yAAntuB+hAoR
         cjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763970966; x=1764575766;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jevOMx3oLEe1om5TMl1VbYUf8BPerVwJX0XKtmooeDg=;
        b=ZnIw9k2w5Wbkcve36Tg/76pJLMSR/7oUU8/2PD3B8+OoV/mSIEA2B4xZUj+heaMDOF
         kTbDv4GZqldqdt70qT9kRoXyTU5SUj7SHBvQ28kDTqTejAxLvpitDVqV1tzZ/dthuvax
         VuSw8SDr3RPXyeATKeG9B5xMdS+XRXKyV7RVfNfCZxB/fsHh3bawlSVh1PeOVJsLT7NI
         6XZBaZYLKh+titQHuEzp/0SqS8Nnou9r2fkWTbSAMWv81PKgOkHCVPEXfr7+UIRWXLqo
         3MqQJEuYlOa735yWxj/j4mvMcrYhSXEsDjlLRYKSVGoa23bZwx+JAHg5UELw95XsHpGa
         klqg==
X-Forwarded-Encrypted: i=1; AJvYcCXYybxVrnXTLrwUOsPU1Lyy4o7NZ7P58q0PGc9Ep7Ri7WPS08gGyxG3H67OD/D43CA4YiF/oFoPaFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNChsvDF02xs4cuJOn4BodJZXNrp6ccjVh5n8fJT6FQGOJ9QU
	A98Eccjr4xKN9Xcqy4xx776XEoSPENHplvcZkfxAWmRkzD1EAo83q1i3OvUT+imG4cI=
X-Gm-Gg: ASbGnct6Z2etbJMjipxDGDk1CH7Mo2Fvz+NmUJud7T6Y2C1iy+Pop3KbNuaTDJNIX5j
	SK5jNHs73eoYnix0xlbHIJJIbCe5yK+8CvTYsFw1xWACKRcLuScmh11cpT4Ds1rJTVxxTkfEkKY
	HHa0Hh0n9dCGP6B7kWgKFEy6TpGq5G6I4HbjXFqDV4nnBxMsfMuHQwTFb92tp7q8Cx15m+Q8ggR
	Z0m+m8HmrmMLnKPa24qhAEwLYjDZ5/RX6geZ+QeRdA6LPTHYpLNgR/hAPWlMZsoAfkFngl2NIoU
	z/wPEBuSzA3/I/1YNqly1e5tEHtfOWTsuk2y6V4F54G0lNhUEv51fGxA0UnZxeNxW0SUdcC5zZX
	WoLTXMrZ4hAW42uTIWmcpGuXwFEPG0vaxr2Z0Yyg+LRPfc2bpyud/NhSoTWBsogbrLkbsvCegSP
	lb0PbObLkH+hLzTnRs
X-Google-Smtp-Source: AGHT+IGauUJhBlDbnXjFSxEh+PpKEMlvDKN50dHKR7OGhLF8ypS/QohDNva+MjmJzH5ntpRg3haGng==
X-Received: by 2002:a05:600c:1caa:b0:477:8b77:155f with SMTP id 5b1f17b1804b1-477c10d4935mr107988885e9.8.1763970965580;
        Sun, 23 Nov 2025 23:56:05 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477bf1df334sm179780935e9.3.2025.11.23.23.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 23:56:05 -0800 (PST)
Date: Mon, 24 Nov 2025 10:56:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Mark Brown <broonie@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next v2] spi: Fix potential uninitialized variable in probe()
Message-ID: <aSQPkfkiJ0w-FJMW@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If the device tree is messed up, then potentially the "protocol" string
could potentially be uninitialized.  The property is supposed to default
to "motorola" so if the of_property_read_string() function returns
-EINVAL then default to "motorola".

Fixes: 059f545832be ("spi: add support for microchip "soft" spi controller")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Add an error message on failure.
    Default to "motorola".

 drivers/spi/spi-microchip-core-spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index b8738190cdcb..16e0885474a0 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -295,10 +295,10 @@ static int mchp_corespi_transfer_one(struct spi_controller *host,
 
 static int mchp_corespi_probe(struct platform_device *pdev)
 {
+	const char *protocol = "motorola";
 	struct spi_controller *host;
 	struct mchp_corespi *spi;
 	struct resource *res;
-	const char *protocol;
 	u32 num_cs, mode, frame_size;
 	bool assert_ssel;
 	int ret = 0;
@@ -320,6 +320,8 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	 */
 	ret = of_property_read_string(pdev->dev.of_node, "microchip,protocol-configuration",
 				      &protocol);
+	if (ret && ret != -EINVAL)
+		return dev_err_probe(&pdev->dev, ret, "Error reading protocol-configuration\n");
 	if (strcmp(protocol, "motorola") != 0)
 		return dev_err_probe(&pdev->dev, -EINVAL,
 				     "CoreSPI: protocol '%s' not supported by this driver\n",
-- 
2.51.0


