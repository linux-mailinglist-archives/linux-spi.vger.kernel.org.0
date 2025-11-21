Return-Path: <linux-spi+bounces-11452-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAABC797A2
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 14:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E4F34E528F
	for <lists+linux-spi@lfdr.de>; Fri, 21 Nov 2025 13:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50BE34CFD3;
	Fri, 21 Nov 2025 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x+L1LBMS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A243A291
	for <linux-spi@vger.kernel.org>; Fri, 21 Nov 2025 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732109; cv=none; b=NJ0dpmGag4WkwvNS26XvIvvcKsyOcJS8WWfKtGCs3uAUC2zgJPmYlseej9xgm6ZAwAlnC6CCLH4gD3KRtlLPpcvZa/bOUi+tEg2VUVE2yvPjVksRxHHYhzTEo2CD5WQT+JOh8LuQx9/pFdNDHzvoyHf+ThdNt2c4r/bOn6A9JYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732109; c=relaxed/simple;
	bh=hktJNp5r4PgkBcqCirMqTHzK016VyP4+D5g6LVifXys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XJkI4Pld3mRwv6OnWMUKtY/4Wqw+/Ke8+COzd3QTttjg+Gdf57fDDWiGSY/xaYzca9jmYnKoqfrL/9WxsBhjnk2zWh4NXau/hX/o5fESt+3iECagNIuSupXRthnpr6Y8fIF94NW/370M+31v4vFSiJjpZ3qij5caaFPFFbUqiI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x+L1LBMS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b32a3e78bso1696103f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 21 Nov 2025 05:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763732106; x=1764336906; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nqvrWwIAH98E3GCNn8rbqv0Z1nqQqruLCAExUktrPVc=;
        b=x+L1LBMSKE8b6NZH1KVFUhR+Pknn1Y//kAjS6KkwaBNO+loLZh+VZCSoLQe7MMmXa7
         Exp0tSyzmpWtBfUt485jNDZ5BtgC8K+6Aht1ct5mSXRAKitzCQUw5fmh82FcAgMWgxGP
         UIXFmeM3DA9EoyaornbeNVAIpSM3EjNWqpqGW2fQv8XA7X1IhTXNMnaJuZITPu3lG3RS
         SzEOOlZ3ZTMG7LPP4Bc5JIyO0ub/RQSSZQqJXcFlZTbcjSKbpr68J0U9STMcrvpppKJr
         zzrr5oF9ZzlO5GXJ6wIF+9kQlQO0KNWqmEMFnFaqt4+IaJEppbgpBRAP4efdMt47P7Mf
         Qkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763732106; x=1764336906;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqvrWwIAH98E3GCNn8rbqv0Z1nqQqruLCAExUktrPVc=;
        b=GHMaejrAlDlgDVySyEsHqpOV1P5wW8esRks6Gt4g5AGdIVsIaYe/5EEfsR+IF3tH0j
         VsL/GBLfvJQ3Nzu4txyOAGgN9QgRGphhq5wwsFQ70BXk/Wh7UGWHZ2nn6vgDzYoOGFtM
         61l0aOnefHRXT/xfKmiJ+vME6NurlRpgICOAZn9SNiucBLjo7o9dxGgXhLz6pFhCuXYm
         ZJvp6eN/dTGj8X9HHySq2W5GGoKF7kdP5BfbqdYLiHhsegwGJgzVhoFJ6G8kgWAiV1Yh
         BUO2Q3OhHP9sJ90aLoCmd0evktGTAIsJEDA6wsirzw20rgJ6a2TPLi4u/VUMvPDzgasp
         sP4A==
X-Forwarded-Encrypted: i=1; AJvYcCUzMaLnzhfaiR72k7lGCaYbQmYM8hwkQkU6WXl9Y64dxnbcWfJoZyyFuTI8NcFKl1fhV4yL6X6SYOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKSHLGuUW7qKKq0LYEWlx6LwnYf/4ruoQByWL84vY6LnipbUfM
	r+ZlpLT8LJ4Q41/5UWg6q+AfgXA0Z6A2jghbG4kMbmrCnLfxEtHMPWOIpNb/UhhFrFc=
X-Gm-Gg: ASbGncsyrYmbujCCgfz4/cCWXalpg/jakxy+uTuN5Un+jSn5XvsqAHSCepIdu9xA+S2
	1HTzYuLhxtsxAau5FU1rug9EM/gCyjzjXHeIdea2N8fWwJZY81RCmbn6wsM0Vrwmn8bAagJUpf/
	Lp0TMr8T02EMdVoHJcDFnKZv4TUPywwfV+PcSfWL2br61K90IAbQZRMEs4S2jtkymanC7008tpk
	qXt+cNNTCKadsaCodMA0c4sXbJtYyinUejyIq/Tr0ltr3wuqYMYJbI8rqzNftbfxvEPDg/OliUQ
	5zQBafev2PKiNvujJnwL2gHN3DYH/I+vTefGHSY9ykCnVpe0+pGH5UAL/bccKsS+jVPk90uGfWn
	4t/qRMFUzVQzwd235ae7Bwj5UhJ+g4OSbA8CXlg0yKB5VZK40UVbBgnmOXmiSVWv3jeweupVMNC
	LxCU2H5FTys/l3JkZ8LyCKPZRQa5w=
X-Google-Smtp-Source: AGHT+IGAAZuJMb35YVwVd0XVBpgFQcFth74Yu5RjXUkruWgElazXjr2FU56f062qpHqju9zFoGQDCw==
X-Received: by 2002:a5d:64c3:0:b0:42b:3825:2ac8 with SMTP id ffacd0b85a97d-42cc1d23eb5mr2641946f8f.59.1763732105589;
        Fri, 21 Nov 2025 05:35:05 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-42cb7f34fe8sm11150653f8f.15.2025.11.21.05.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 05:35:05 -0800 (PST)
Date: Fri, 21 Nov 2025 16:35:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Mark Brown <broonie@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] spi: Fix potential uninitialized variable in probe()
Message-ID: <aSBqhdjiywXq2Aso@stanley.mountain>
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
could potentially be uninitialized.  Add a check to prevent that.

Fixes: 059f545832be ("spi: add support for microchip "soft" spi controller")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-microchip-core-spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-microchip-core-spi.c
index b8738190cdcb..e65036cc62f3 100644
--- a/drivers/spi/spi-microchip-core-spi.c
+++ b/drivers/spi/spi-microchip-core-spi.c
@@ -320,6 +320,8 @@ static int mchp_corespi_probe(struct platform_device *pdev)
 	 */
 	ret = of_property_read_string(pdev->dev.of_node, "microchip,protocol-configuration",
 				      &protocol);
+	if (ret)
+		return ret;
 	if (strcmp(protocol, "motorola") != 0)
 		return dev_err_probe(&pdev->dev, -EINVAL,
 				     "CoreSPI: protocol '%s' not supported by this driver\n",
-- 
2.51.0


