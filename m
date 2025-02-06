Return-Path: <linux-spi+bounces-6646-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E89A2B471
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 22:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7931889E8E
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2025 21:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E0B236A75;
	Thu,  6 Feb 2025 21:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oB9siOYW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F92225A52
	for <linux-spi@vger.kernel.org>; Thu,  6 Feb 2025 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879026; cv=none; b=UiP+LrDwG4ffYM6aE+Tw4fWEyvpfIleP2o6ow5N8jkeFag+pRnCA8EdA7JNNJ7pJwPGp5eJqF4RQOUPWhDWEyz2fAevZDZjASRraVJOsRnCiQjRoGchg3fXnhw+fx/VobdnnLQ28xq1rMHUyArc9skpYcI1dHKPyjIN1cLVCjyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879026; c=relaxed/simple;
	bh=fCGps71ExS3xEFEZS96sdmBBtj4gTo2oNtyxnmOZAHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kJhXbpPG/2sLiJVkv1jhb/GuaWBFDu4Pj5jikuvk4IWR8sUc+6eDKuVCpVnPuT+9dnJPiZJi0qrlRA4+vikun2spl+eeb3/IdNDOVNBxrCehNwtH3BjvqEt/DkdzpA80jlSSHdawgbAllwvsDi/Gmv8I2Mu05VgXDXL02ls2Brk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oB9siOYW; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f6b65c89c4so363123eaf.2
        for <linux-spi@vger.kernel.org>; Thu, 06 Feb 2025 13:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738879022; x=1739483822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3toZZ5wmMiBdVoGCpQ70K1bSeRr7FsLK1fQOBhlIeM=;
        b=oB9siOYWb+Zq1WCC0HAQlGFLyrRzjdB4reej0rVp0iggtMpx7PUK4aKwD2mEgyRia3
         YJ7TOaphLscnX6hhG72u6Zyib47YLrswml43/Vi9lU9xaAFnanGxAGKsI6Oz/Ru9cAUr
         GGu46Iw4ymxlxmxwJuseNK3qADaFaoqxxX30w+YlOVdnBCTbRl94JSxe43TRJyh6x639
         CuhfvRrmXFVzRtlaHo8APWO0L8bkTNXgt393xR4r4hsnTBezs4TMG2kvthYtv5kRzEg6
         vAi0g9dOEgwqkvbv3DqioNXylCPmf+YUFyYodEUtjTIkMCtr2GSkrfmr2qhOP6srofou
         5mbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738879022; x=1739483822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3toZZ5wmMiBdVoGCpQ70K1bSeRr7FsLK1fQOBhlIeM=;
        b=BdGL8bRiLJJB26jjSyFbH6QKueRnERF+qN9PrgtFFz50Hcc1OIHAhN/nPixyDkwi1K
         A2Vy1rWtqBVwILc9T9bZ1t8JAmAinhTjKG14MLlO+nNhQN9Ou+abihRD++DHpX7Y+7iH
         vyCTgWiaN3uFv6TTJ1JphB+cBJn7ISBvwq0K6J5w5JA+IgCziXjVWZxwiiQDgp6cp1Hh
         fK5keCr2PvkYvT5vWL6cYrkY+dVJMSGvRI18CSNJgxZJmlJ98cTaKSue4sq6QpiR0SEv
         8omX8XwAom9AOZbB/SVfMgWVLzhwBYdoR11cTuGG6zepSU6NlMjtZ3zFj9LESpVNKdou
         GWiw==
X-Gm-Message-State: AOJu0YzBry6HGmUU38w/hGvWmOhjg4ePro2jeFi0CmI/E8/XcyC6172z
	/6ClOYHBJUtmXiNg5zNCCUrsY37np0XW+HCpZ1iJf9wPcTLigzS+5RigBQD0ePE=
X-Gm-Gg: ASbGncuZXFC8c2sGBhgI+lPRMF7YDFoCDtGgnbdrSGcKf8wfEF/DDhrQs3a9b8sVjD8
	s1EqiL44vgZ1r+uHqMxXO6pxrMoCtZEqsbD2Wus/DG+2hH1tIAEMEF4m6qpS+MfLddobOfBeov5
	yhDSrO/xVfbv2GAYOsVTJSPG9T1OG+EYxJuBFeBolA2X9KI7Hu58yhZsI7LYCEAdRZhCFyOqOwv
	JOR0gNawKi0l5zTSOAAmH4CsbPtLsouj8554J2bm2wgJNH3Hlq/croKiS99w5TWU18Fj07J8kPB
	MoKHgxlwH9YoG5XLP9cLs6LyM6YzAUHq3PkQOGZC1Al0wz+xTlAIev10N5g=
X-Google-Smtp-Source: AGHT+IFnJdQ/ccw+KIuBLF0Fbom1GPawpx01R24tEd9AGsf5ipJlFwPqCo2QQQmGrn2+4mAWrKyuWA==
X-Received: by 2002:a4a:bb07:0:b0:5fc:5f46:2893 with SMTP id 006d021491bc7-5fc5f4635f2mr300810eaf.2.1738879022445;
        Thu, 06 Feb 2025 13:57:02 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544ec855sm452948eaf.19.2025.02.06.13.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 13:57:01 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] spi: axi-spi-engine: fix missing bitfield include
Date: Thu,  6 Feb 2025 15:55:13 -0600
Message-ID: <20250206215513.2842270-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix missing linux/bitfield.h include needed for FIELD_GET macro.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502031224.wvHipe06-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202502031250.64gElGDs-lkp@intel.com/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

Hi Mark,

I know you prefer patches like this to fix something in a patch that has
already been applied, but it doesn't look like you actually picked up the
offending commit[1] yet in your main tree, so I don't have a commit hash
for a proper Fixes: tag.

Do you want a fix like this or should I send a v8 with the fix squashed?

[1]: https://lore.kernel.org/linux-spi/20250113-dlech-mainline-spi-engine-offload-2-v7-7-e0860c81caae@baylibre.com/
---
 drivers/spi/spi-axi-spi-engine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index dd6077d3ff7b..da9840957778 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -6,6 +6,7 @@
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
-- 
2.43.0


