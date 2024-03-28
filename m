Return-Path: <linux-spi+bounces-2084-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD8F890B9B
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 21:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D4F1C3046A
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 20:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0564513A871;
	Thu, 28 Mar 2024 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="da+QjHq/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D2C13B5A0
	for <linux-spi@vger.kernel.org>; Thu, 28 Mar 2024 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658409; cv=none; b=g835vQD41DymzmL7iraHvEOp4mINIk2F4h53R8Zw7eIgm25A5k5oWdBtsOyzCKsGRwFztqZizfu0TqrH2E+rTHnaZAH7LTv5VRqlzEQNCyucTn5ua4FhXmxYNnKzrfDaGY6XdAH651CzruMcdm/idtPFJgf8rGM8SDf98RCiiu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658409; c=relaxed/simple;
	bh=zEWlRAVtFaEI8DxadpGvvAtmxe8dbfjOZtl4xLuLmKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HqKfMTvcUnCjrGfD5z21miJxZOThsqYsVXcHhULkeGQOzHaTyDTwURRGooJw6RwUUCNjnZWkJBS2z2bawZPkoqm67sVNc5k3qitkwE1pAg/U4q4hc5Q0bFdv57cEV75xseX7tXLFcK+N1EZgh0OfsoV+24KuFoyuldx5COPIwE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=da+QjHq/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41490d05bafso13246015e9.1
        for <linux-spi@vger.kernel.org>; Thu, 28 Mar 2024 13:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711658406; x=1712263206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VLbQp2aBj3c8Sf1EyYJHd+FXAjE39Y7t3rCCxWRWwVc=;
        b=da+QjHq/bIUcVHRMOclxlJakNVF3864/aS4CnbxYpvKD0vqToR+kOtf2mPTDrJzsHt
         /Lwlz7xJzu5bh7br1UpQfNQyu83iJZiO4t0jFkkawqqBsxTsXIZGB6ZKQqTFBVaHQ6Zb
         xOKtlG7lM4fCdX5TkmDFF/lRU9GKkrNjCJtI2sZ7JfiDD+DUhpVdl8gmbX9y4yfKq5ll
         TwbY24hYhRT5++Ww1VMHk3pY2bAqc+itIJeNk9e/rTnNR3e1ySRTVV8ouVhPEFw0RPuf
         MPnSwhDEgbcxoyrS/3JY8UQo29ogw4JJYMQo0u3WPc2fqsTS3/9MxpgIBqnCoy01wEIU
         HrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658406; x=1712263206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VLbQp2aBj3c8Sf1EyYJHd+FXAjE39Y7t3rCCxWRWwVc=;
        b=omoyWfZ0QSNrY0PiJjNegtJadMjGN7S2d1JAhMM8ywZj1UdKfsmuZIVcQPIOngh94E
         2NC4bQlUiCCbsqLHHmftt2z21Cbx0Qi+XQK9zAcbKaOi+9HrVZvIy2FbT0QrEBCEqVOS
         gh8STq80o324eAIljcGm38AfleeS+ADXfNRc4G4+52fH/hVFXDWCs5/SBliEIr964urn
         JlBMfHGUJ4azjuVOozZKLLZabBsFFgX0ySwgDMbjnq3O7EWfB8n+Q523/M01SdY1d5H6
         2IYFeputPIsflQEU5eLXnhl7zok5TE/XgITQ1kVgDDBimVtvcuZkWloarXfkM3/uMWIP
         5pUw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ98PyQea/nlBgLgtPlbOGODvNVw1XXL+DSYWDJNfNkq3Cy6u3GhxGJS+5zP1PJHxBcwPlhl5mBBCVhpyy2tmQQAv0OF0gCBAB
X-Gm-Message-State: AOJu0YzdUqjtZJCqkoz+a1DZsqlCWXdI9ZiKsbxmFrpoBbcfxS/xYS1C
	keDPmsx/a9eQIZn5riyso9YrTvYwMsg+nSy2y1yMs8WtAYX00hY7Q7I+VMyqiwI=
X-Google-Smtp-Source: AGHT+IF++QFH8AOoYnDjeOKcnQ9MoOPe8E5nq8m+tccUcRQiEMmq4UK7spHzq8R7jkKYNFuy2/G//g==
X-Received: by 2002:a7b:c3d3:0:b0:415:45ea:9904 with SMTP id t19-20020a7bc3d3000000b0041545ea9904mr422278wmj.21.1711658406441;
        Thu, 28 Mar 2024 13:40:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d6350000000b0033e7715bafasm2586613wrw.59.2024.03.28.13.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:40:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] spi: docs: drop driver owner initialization
Date: Thu, 28 Mar 2024 21:39:27 +0100
Message-Id: <20240328203927.156184-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/spi/spi-summary.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/spi/spi-summary.rst b/Documentation/spi/spi-summary.rst
index 546de37d6caf..35e1970a76a9 100644
--- a/Documentation/spi/spi-summary.rst
+++ b/Documentation/spi/spi-summary.rst
@@ -348,7 +348,6 @@ SPI protocol drivers somewhat resemble platform device drivers::
 	static struct spi_driver CHIP_driver = {
 		.driver = {
 			.name		= "CHIP",
-			.owner		= THIS_MODULE,
 			.pm		= &CHIP_pm_ops,
 		},
 
-- 
2.34.1


