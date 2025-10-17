Return-Path: <linux-spi+bounces-10713-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C508DBEA9E3
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 18:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC9B558230D
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584E15227;
	Fri, 17 Oct 2025 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7zQ7cSB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB62E571
	for <linux-spi@vger.kernel.org>; Fri, 17 Oct 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717082; cv=none; b=asQTGeHNPTILHIL35oxriOQOs3Yzz7TNByXmF/d91u/ctRTkxyL5TdxR3BXQPCVXCHmhQKfuGD9pZr9t2qTLhwE9vSuBF6oUosC/ZtUVdhvfUBkWZuaBZhIcsFbvBEW4JNdA7eItyHbOtmGSmGiCkpXnDEqPvP15I8vF9j54ijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717082; c=relaxed/simple;
	bh=21MzbEOZZxXcBp8tJHgBWsUDFReLMA5Fun7i72mkmC8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ac8dQSCetKydR67f6Jn1r0c12Ce15ql7ICMBEuNCEznE0Jgv6fPzYwXy4w6hkiHrEnSoA2MawOHVsf09dleY5thrlddry3KqomloaTr0OiCYSJQ3UoEWr5vM5YjDctAYR9efrLNWXkcNyQtuQfMrz74TrOS5OXBDommANEW5llU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D7zQ7cSB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-426f1574a14so1237988f8f.3
        for <linux-spi@vger.kernel.org>; Fri, 17 Oct 2025 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760717079; x=1761321879; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=950Q3osvXfNrhNZDR0R7N+wo2IA1yL5cHorDQTcIxKM=;
        b=D7zQ7cSB9vFPaq/b/m0EfXvPBlSWRXcAguuwC3wCW4e3eDIEjtJSSIT/JesCfDWvLE
         0y3LE96XMeyHVZevh08q03BV4CVKHvitEK8Y9hYA1JeXV86n/k2ZjMXNvlwAZWJqvoEN
         P8rLTY1T4EK3wHVoMPirhx4G0kZvV+5yXbRgWziGDKmo+oRiXOroyftaEsxoYlD4W0kM
         0HsnjZ3dc16xWTtKwSbhEQgILlh4HBYJ6csRoO3WUoyNe3r1EJPLaXMcZu7DeziR2nWG
         g1BuF5Z0LxKTWSujw1yAc9qxSZ2lBHDoYDTdvamiPWh8zsFzcs/ICeiKrkW1quBnRwFG
         jKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717079; x=1761321879;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=950Q3osvXfNrhNZDR0R7N+wo2IA1yL5cHorDQTcIxKM=;
        b=mYiUlG4/+AWE2tiuDb+SKswxOsasmKerNHFFDE+fxLIYDaFsAbo/NohrIHsbN9wutn
         YQtn2gwwFavGq++2/1Jodox7EoQpmKoEgEcHfAap9ChfLtwodj4bTEg/dFk4EP1RRJWT
         N3loOz6HkvidDf7VxRxBG6cWuGphfrqYRo+KRMaj/3Vr+4RmyZxrJsEmZqjTxuOkCirE
         UEPpYZe0qfesxtB7eGe1ojBAgNM6WXU5hRXkmBakxF1aH7fjkDYo3GD54Bk4sXzAymL4
         WuB2XUC7bIGxDMdWZ9W7/j9c1vsFH3orv0G1tVDozFNbcogYPD6QRL+cFuipTX9YwT/v
         G/QA==
X-Forwarded-Encrypted: i=1; AJvYcCW/nqZYK/+vdQH5upc/H6lQU+6vg5KuFolCSopZfwlU3DGIWDO8ONUodeFyxjz/ujBo0bEAk/8l/Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp+hLbdHs6KnWweaNlg74AhvfwaWDLspZbcw+yS2MOdcUIulMt
	uyF06UozaGXL+iBzAQ/d2HNr+oDC4qlBNAUe5IJbiggQ7p1bHyfOVm7JfwOC4px6VZI=
X-Gm-Gg: ASbGncuvkRQjsRXO/oabK7CMaadGaPqNA4xxjQZ5WpDiDwHsIRCLMObNYslBvJGBstP
	r1CW+QG18j7zhxQ8n+yPXWLMtUrUfeGi1IhauAJrnJLZk75oneIdi9IhOR4RNHUw/jacxiBb9qY
	FjKyoLbwHOVcJeRwlPIqmums7EAcpUabIjdTsulEwQbo/DEBJ4JEuAcPAJriH3snKYV0OT6cWML
	jjiHTPnTpNAgdH1DoblO6P+YBy5NW2yunH/FLTZ5H37RFxx2ItlP302Fn288316VWtOdPT/cFV/
	WL1aY576ZeHU6mR5Fvq/TwqnIUAMiZwRgM8mp6flVxeGzDI6a5UoqLh9E4ktmFsJDv9y/1Xbe0s
	B3LSZY9fJI8sncdfDXJRRWkULY+yvBijRxm74K6U13oKX6WXx1qPwNpWWYa8lWdz3McaiN7oaAe
	orIjNN4Q==
X-Google-Smtp-Source: AGHT+IEqaf8aEdQodsl+JMqmg15To8fNumQ1pcFMtGOlWgs5DrBRbhx4c+4oaiAKATvKgQ4yjwGtCA==
X-Received: by 2002:a05:6000:26c5:b0:426:d72e:9924 with SMTP id ffacd0b85a97d-42704dd6cf9mr3110630f8f.51.1760717078511;
        Fri, 17 Oct 2025 09:04:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427ea5a1056sm544f8f.2.2025.10.17.09.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:04:38 -0700 (PDT)
Date: Fri, 17 Oct 2025 19:04:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] spi: aspeed: Fix an IS_ERR() vs NULL bug in probe()
Message-ID: <aPJpEnfK31pHz8_w@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The platform_get_resource() function doesn't return error pointers, it
returns NULL on error.  Update the error checking to match.

Fixes: 64d87ccfae33 ("spi: aspeed: Only map necessary address window region")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/spi/spi-aspeed-smc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 0c3de371fd39..822df89cb787 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -865,9 +865,9 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(aspi->regs);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (IS_ERR(res)) {
+	if (!res) {
 		dev_err(dev, "missing AHB memory\n");
-		return PTR_ERR(res);
+		return -EINVAL;
 	}
 
 	aspi->ahb_window_size = resource_size(res);
-- 
2.51.0


