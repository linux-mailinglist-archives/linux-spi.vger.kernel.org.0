Return-Path: <linux-spi+bounces-774-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1B383C59F
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 15:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8812992D3
	for <lists+linux-spi@lfdr.de>; Thu, 25 Jan 2024 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403A31272C3;
	Thu, 25 Jan 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i33UVdeS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C8677621
	for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194230; cv=none; b=psZvblrW5S9X5QWsc2oMPEy31Prcmi2+0w8Nh2sl1XEQnsE+qQ3agiVgo6/ZQHrSEwlNVXkONmwBAiJmBaZvpmQwMtqVRlSYOyPCwe0H5Rw1lGDltm5QkIEZVW5y4gxEAukdPSRyf5cic3qiA2leN57KAHfp47pA905vGdHylQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194230; c=relaxed/simple;
	bh=gtRjK9ate6cfXTC9U+V8PXprjWWb+VN9a6nG6nym+rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NP/olApcii3jvBIYabDWK96I2u3FYw+xnTUQKstY2I8ZUOHTlfKDUNwjV+wTi58YhKks51Cjxu34p/eNLFLNPrDMA/gSlwxoVl4ATthejb7BblJEnm1X96z206V4nfhNsYEy/JjS1YV2Yk1ngMG17SlEBNvs5KUMj4k0A33tCNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i33UVdeS; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3392b045e0aso4646232f8f.2
        for <linux-spi@vger.kernel.org>; Thu, 25 Jan 2024 06:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706194226; x=1706799026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acZkx4VNztJup6SVFgXWaorvVUHU+cfuLeTiXLRYn7o=;
        b=i33UVdeSFZqzdHkXRBqoBc9o2SfXT9yvpElxWoYYfXIdYV4OH1Q3Hsnd2jpVYr3Z3t
         XK8lnn8pZDPF1emU83rxeyKCUWxxKvxFTG8d2+gSiRuTWxJqNGGHoor2LbSMPRuK3m7d
         i9wArelESphzI9QL8RoWh72b7qjOmISRqskOxW2nxjBWGWuxm9dbOhc/CAc/txBBMszq
         c0demzua5toymSOwgDoNZ9SWkL+tU54PP14o3K2JD0cTJAWqRFxcgRJ7wMVrv5GHydEQ
         vt/w31ICWT8OpYlSUf1/ohac+Adie6DOTA2I9hG9++mGdwGt73MU0BgMjGHCEB5K+HNL
         3KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194226; x=1706799026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acZkx4VNztJup6SVFgXWaorvVUHU+cfuLeTiXLRYn7o=;
        b=Fv0njc4+DZzv9wR5p6ey6GYLTaOXetMT0XSh4tc4c5rbeAZEoLilcTwzGrmkpCy/u4
         4aKyiBFhWS9mEyS/q5mODLz2odzVuO47BcUjTrV4oibA1VAGJj9Mt9OdHylIxsbQhcRL
         QN/JpcAM/e5rx243lW+QrI3SFiVlQFgYKmrpPgJP9UAWjBvcoG5P2EJPEI7noB+if/aM
         lLaP0perXY5xdCd+k5xONYW/yhkkgcDd9nkjGSDOmk+JhAId0D/+NLtuo+mAqZe7h9Rd
         3pyQxGA1kXvG472X6Cgv/vqiAPIfrOR0DWrAnTjeFn0BMG8p/78yf8GZaSM70Ptmws/k
         q4pA==
X-Gm-Message-State: AOJu0YygCDIB0Cj+BjOEyTcLTJgkf70c+ro7jYsvhnly0KBmoENCC+s+
	ykQZrufDNj1UGoucVSsmgnTo7whU8fTGYNORTHWwkgt35tpkWS74McV1DbspCWU=
X-Google-Smtp-Source: AGHT+IGcnVEdRBdNCJ7q8be0pWxELhjMkQy9t5rKO4stIGgfq2kH827TzWGaRyRDaSyBrj8tirG34A==
X-Received: by 2002:a05:600c:a686:b0:40e:5a0c:21bf with SMTP id ip6-20020a05600ca68600b0040e5a0c21bfmr633707wmb.95.1706194226510;
        Thu, 25 Jan 2024 06:50:26 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0040d91fa270fsm2875875wmo.36.2024.01.25.06.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:50:25 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: broonie@kernel.org,
	andi.shyti@kernel.org,
	arnd@arndb.de
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 18/28] spi: s3c64xx: fix typo, s/configuartion/configuration
Date: Thu, 25 Jan 2024 14:49:56 +0000
Message-ID: <20240125145007.748295-19-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125145007.748295-1-tudor.ambarus@linaro.org>
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo, s/configuartion/configuration.

Fixes: 6b8d1e4739f4 ("spi: spi-s3c64xx: Add missing entries for structs 's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/spi/spi-s3c64xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index bb6d9bf390a8..692ccb7828f8 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -174,7 +174,7 @@ struct s3c64xx_spi_port_config {
  * @cur_speed: Current clock speed
  * @rx_dma: Local receive DMA data (e.g. chan and direction)
  * @tx_dma: Local transmit DMA data (e.g. chan and direction)
- * @port_conf: Local SPI port configuartion data
+ * @port_conf: Local SPI port configuration data
  * @port_id: Port identification number
  */
 struct s3c64xx_spi_driver_data {
-- 
2.43.0.429.g432eaa2c6b-goog


