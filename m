Return-Path: <linux-spi+bounces-9687-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D4AB39949
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 12:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7651C20C87
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EE03081C4;
	Thu, 28 Aug 2025 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/D6/cS+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842A1BD9F0
	for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376127; cv=none; b=j0ahAPHEEIuvnQjQhWs+0JE7p8Jsl10qdacYPhr8HXzohwl5vsd9iOVW2ue9Cnh5hhyGPnN2JZAH2YwEFY2SwK+bHWSluACVaNJckT1HLDcn7QD2gLYAwt8VUIxbG4bNkqSbEJpq4ycfcw+feRv3GrZQX+qwv4QBAdKWNYSHSpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376127; c=relaxed/simple;
	bh=x3Xcu1z+CtLQlbgjL7Gni2IBKCEYZWwIRYW4Gql8iLg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VjkIiBlKDZK8xloSunyDrV55Fg52WFons7xcx3PnsFHFAY+l6eIOwnQG53RWX7EQgvgoYhVUVPn1viSGlHKgLUvFRnpv8/l9s5fIhY7Eq3PXDo1DqIKtiBqcRg/cysY4FapNEkBWbQ5vcvEJ7lxWyiVDk6GNRGq5YNRHGYzil98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i/D6/cS+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3cd59c5a953so501585f8f.0
        for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 03:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756376124; x=1756980924; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5dtsWOrssFq6dCtiMfrdoC2rXhSI5ZG5/AkQSWPW1V4=;
        b=i/D6/cS+be0Rd/q4pOhwhxG7GES+3JBl8WPBeHv+MqWhpUFGk+6RlI3anRKtnrKk3f
         WoxN0ntwFMg76MrOAzhtNXlmHKgs9w0bSUMrXpG4aMrxUyLXkqwTo0AF4KZxml6ASIrQ
         Kr5QnXwHv9LaxKSzbUW8Moeg5alQzA2W63E17PaBvVH0zN32qmE75Gl15lByS8c64E0l
         c3y0l8psJJBkL/5X48eR28h/3Ba7GsK4VQyyHwWQoNc8XoMSdLH7EVy3DXuWiKn6GHF8
         JW5j+AgV1LVT+/8YNp9V2OhaK903GXcH6QUgqi5x8NAiVQDExqk+TmmmZ89AyjJanSgI
         mrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376124; x=1756980924;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dtsWOrssFq6dCtiMfrdoC2rXhSI5ZG5/AkQSWPW1V4=;
        b=RZ8gq85xUIiKkO5Y/5dJT696466K3Q1DhtoC7J3p9vcUj9F+9cD1Va0LaGWt9bEjYo
         4VgeEdACmw8hgsyQTK6bI9pmuCSaKUCEbIlYZVqn51DQFJvmBU9byqCKL08HX6o7Pn8S
         s7wYtTT2nIfPonIjR+n1MG2ON70rVsphqUV1H+v6AQJsQ86sl88XtIN+Nc2EIDWuwXTG
         YdSy6OC+Ygkm0BygjJybTjs1n/Cjik9mJlOGlcaKsOXS7vxdJzkPLKYb1CuTn9rvYTR2
         pQwOm16jze2yw14BB4zaPNUtNNkk5tIfUb/IE5AtHgBrndtqRXBTUyN2WAGtzZ6BjywX
         720Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLs7SBTEVZyQZO0hxkn/GG//zbUaCBrPCp0Akq+XrfKGiaNzNDxWfGQO9JUdrlbppLl/GzOmn+XEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7TxfXg4eWSXaGgPz5Om4KnBrpmXbegUn0NLMGWK22nBVRLuO9
	knH0CuaEWb0GlqPeghgEr9edCBk2r0hw4igu8GYcUaZMy1egMvBOGmzekYULiGOG2wQ=
X-Gm-Gg: ASbGncs194XxBADRmV3d01w9s8OPoRijn/D6JTqAV4WqNWFaBsgMaeFOk1YBArnYNKE
	KPOVZweQlS+Iq34yp69+7Y47jdxJhWaKmkIitE83syWFaIm/LQBkkwMBgEHuO9EsG1imZ3pqYJ3
	fpRliRTfhCWWQtDgAvmy/gM14VIyuU8UrGTRsLyCwW+P86PbPxLxU3cYX1Wh2Pb16uYbWngcQv3
	BWF7SOM+zBsjFJH5G1tp0uB5MM+rVXOa1iutaAHTDvn6kLdSpXccCsvuCgjWaVdK8HPw0Uo7ayK
	5ZsIi+/7YSi/IGMDtDvXPCC974PsjVNIkJ2btSKh7ZgGLvYsEYJTMjNUXQ90TcCFUIXEE8+Tapd
	UY4WNXUbBj+y7YiTtu6QApWx/VwZaobxtXGoARJ0vNA==
X-Google-Smtp-Source: AGHT+IHKf2aG6pLYrFaDWGlL7FrtoqqzoGeCk3EgyukB/f1w9pdZhxPxMSnGHp2vNNZqCXF6rvJJMA==
X-Received: by 2002:a05:6000:240c:b0:3c9:9ec0:203b with SMTP id ffacd0b85a97d-3c99ec02f4bmr11349567f8f.27.1756376124175;
        Thu, 28 Aug 2025 03:15:24 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66f2041fsm49976305e9.5.2025.08.28.03.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:15:23 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v2 0/9] spi: spi-fsl-lpspi: Generic fixes and support for
 S32G devices
Date: Thu, 28 Aug 2025 11:14:39 +0100
Message-Id: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA8ssGgC/22PQQ6CMBBFr0K6toYplBZX3sO4KHSAGiykNQ2Gc
 HcLMVGDy/+T9/7MTDw6g56ckpk4DMabwcbADgmpO2VbpEbHTFjKeCqA05u6o6d2Gmk/+tFQaFT
 NJQqmeEkiNTpszLQZL9eYO+Mfg3tuAwHW9u3KYOcKQFOqy4JlQqomq6tzb6xyw3Fw7ereQAn5f
 7DkstBCAteQf4PrFYF9lmW6/yKwKMhE2YBWVSEQfwTLsrwANL898CkBAAA=
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Larisa Grigore <larisa.grigore@oss.nxp.com>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com
Cc: James Clark <james.clark@linaro.org>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

Various fixes for LPSI along with some refactorings. None of the fixes
are strictly related to S32G, however these changes all originate from
the work to support S32G devices. The only commits that are strictly
related are for the new s32g2 and s32g3 compatible strings.

Signed-off-by: James Clark <james.clark@linaro.org>
---
To: Frank Li <Frank.Li@nxp.com>
To: Mark Brown <broonie@kernel.org>
To: Clark Wang <xiaoning.wang@nxp.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
To: Larisa Grigore <larisa.grigore@oss.nxp.com>
To: Larisa Grigore <larisa.grigore@nxp.com>
To: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
To: Ciprianmarian Costea <ciprianmarian.costea@nxp.com>
To: s32@nxp.com
Cc: linux-spi@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
Changes in v2:
- Drop changes to be able to swap input/output pins. It's not required
  for generic S32G support and we don't know what board it's for.
- Drop binding change for max num_cs value. Although the maximum is 3,
  this would be autodetected so it should be left blank. 2 is the max
  that is required to set manually.
- Fix missing bitfield header for some compile targets
- Keep prescale_max as a numeric value, but treat 0 as no limit
- Put compatible string dt-bindings patch before driver change
- Link to v1: https://lore.kernel.org/r/20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org

---
James Clark (3):
      spi: spi-fsl-lpspi: Constify devtype datas
      spi: spi-fsl-lpspi: Treat prescale_max == 0 as no erratum
      spi: spi-fsl-lpspi: Parameterize reading num-cs from hardware

Larisa Grigore (6):
      spi: spi-fsl-lpspi: Fix transmissions when using CONT
      spi: spi-fsl-lpspi: Set correct chip-select polarity bit
      spi: spi-fsl-lpspi: Reset FIFO and disable module on transfer abort
      spi: spi-fsl-lpspi: Clear status register after disabling the module
      dt-bindings: lpspi: Document support for S32G
      spi: spi-fsl-lpspi: Add compatible for S32G

 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml     |  5 +++
 drivers/spi/spi-fsl-lpspi.c                        | 47 +++++++++++++---------
 2 files changed, 33 insertions(+), 19 deletions(-)
---
base-commit: 07d9df80082b8d1f37e05658371b087cb6738770
change-id: 20250715-james-nxp-lpspi-1fac58e72a59

Best regards,
-- 
James Clark <james.clark@linaro.org>


