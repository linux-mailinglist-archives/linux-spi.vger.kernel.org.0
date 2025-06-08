Return-Path: <linux-spi+bounces-8381-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346B9AD1570
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 01:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7373168008
	for <lists+linux-spi@lfdr.de>; Sun,  8 Jun 2025 23:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0331B1CEACB;
	Sun,  8 Jun 2025 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7puLwu3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726771D61AA
	for <linux-spi@vger.kernel.org>; Sun,  8 Jun 2025 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749423870; cv=none; b=s8erIab4xYZp+bg5bOlC0++wrKmwNOCErsGb9TGOx09EVc+SV/H5uQMBnJi/hYb2LKO9FatKFLJEmetj6uO+l6oVs8acE6oABA5sf1OEuVyE3y2zHBrnW5w8vL5zUHT4Ytql9EosUxU+4BtY2jym25HR03etOvJLAEib8RxDrBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749423870; c=relaxed/simple;
	bh=UA+6z7JBkaecwQBswaFL6cVlWgyzdB45/pmKk/o4oFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DknbpjygxTfewZg52TGZdR0CaDJM7/DcJ2GR16JoTy8W8zNhntsp/BpwFk1FHJbBHPamH/a/O9QyuGlA8qFxB+sZgfzzfOhzs3dDskzREk5yrKUTE3Br2ti9v3C10WP6pzeKyaOzT4Llk54dOKeImlhg7gYvZGGaXX6OfKJgDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7puLwu3; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-530f9edf5a3so287754e0c.1
        for <linux-spi@vger.kernel.org>; Sun, 08 Jun 2025 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749423868; x=1750028668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kiqeoC4lAu8Yz48+QbDST0Vhtx1Oz0jzsdHmOZqjIpY=;
        b=D7puLwu37tUUHWLRGH7TrbScLqg6px71L2Q+FQemzje0l91Nu0KYXuXLqRwtlvT4N2
         uDq8XjbZwWN0QXSNF79vFjp6Juf7BIDBPARpUSYtD7rTC/UpZB6G/k83MOrNHtraUcZ9
         KS2MTJQWexqfuFBjpT0tSWbsa0OysHLP1/C+fxQzp7j3xVqY6Z1ME46GK+M6tZthedeH
         oIAnASRHPqkIAJ/IH6mJl3ygzbEKin/rtDrK3HaT/XEMc3bFUBVsaIwnJ64Sn1w97tSC
         zeF0s741P+8aPY4lc8X4MxQlKKjQKVp0kTluPo9nvjsqWh8eGdgeHIaF4bGLb7PwaE8e
         +VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749423868; x=1750028668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kiqeoC4lAu8Yz48+QbDST0Vhtx1Oz0jzsdHmOZqjIpY=;
        b=QpUg7q70yrBl/D++C1bGEt0Us+GkKsP1R28dyipjAR6QzXpIW/FlFuthM2YW1dRxLV
         N4LCmyHvb64pI1XrA2Dc+FUsORG1t2uFL5dRq/euc85EagVGaZNeyrLRt/IJ9S+3wCpP
         yHHZbb2+BCj3SfDIWlLA46QaveJHe5vhtWnlGr+rnj+feC3tOB0LG9Oijdxj0i87kvuS
         FC9CvVT2stwaS6GXAaTMIebyI9fgcIwAeXaO5+5GEq+ekzb/9MB4XSoV+k8CMmf/BUxo
         adfKGwSP8RQRRc27DpAAPHV1cGIcG9aQLmWmr5EPPm0U41GKYvR8arcxGEQj+eFpnMRN
         JLxA==
X-Forwarded-Encrypted: i=1; AJvYcCXa/yJQc/fAdGfJpTCcEGiSx/bVLNiBrmKl+4GBwcm21Zo6fB2Ir4LlyXzBcONuZdNOPHLQVDFLffk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/SJ79TF/rGOH0ocEUEV77lzNjIC/+4yEN55mJVaWAKTmdQu5
	tLZJqvLhkcnqGEYtY9gTTHA66vx6Ynkj0jNavfQwO6w+NPO0vySENnnP
X-Gm-Gg: ASbGnctjs6ReEVXyp1oA4rvoVMAUB/y1kQNq4aMs7S7eyxGBW9i3RoaY7dD688mWDdn
	Hz6ESB1Y0CkzveIPHh4c5mYf4zgwBQ0SJmVuaqHLRV/pKs4YzgBPnXz046LQzsdNai6BiFkrlnq
	tbmZPQayxSpMOQ8E8qzfGSFkEvImAiPJRO1NP/isdAxTr+02NBG1rKPnO3rRB18kam3KR9gFw80
	oqRug8gmuUb5Yp8we+hFVjXXukJXwvHJDdbTFC3yALgNZiW85ivyBIa9ShzM1CxondnGdPymvU2
	zfk4A+AoAvCUzayNPMmwAx+ylWsYLBzjAZuhKnEEDngLrrS/BWc=
X-Google-Smtp-Source: AGHT+IHELQz8rzx+gTtpFPMYrATj0iCzu9ZmP59AWtoc3enK4ARBXfc9t66dZtIq8u5xnQ+6uW8kRQ==
X-Received: by 2002:a05:6122:a18:b0:520:6773:e5ea with SMTP id 71dfb90a1353d-530e48837b9mr9669931e0c.7.1749423868359;
        Sun, 08 Jun 2025 16:04:28 -0700 (PDT)
Received: from velo.. ([191.104.145.24])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-530e6411b07sm3902899e0c.38.2025.06.08.16.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 16:04:27 -0700 (PDT)
From: Andres Urian Florez <andres.emb.sys@gmail.com>
To: dlechner@baylibre.com,
	broonie@kernel.org
Cc: Andres Urian Florez <andres.emb.sys@gmail.com>,
	skhan@linuxfoundation.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: offload: check offload ops existence before disabling the trigger
Date: Sun,  8 Jun 2025 18:04:21 -0500
Message-ID: <20250608230422.325360-1-andres.emb.sys@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a safe guard in spi_offload_trigger to check the existence of
offload->ops before invoking the trigger_disable callback

Signed-off-by: Andres Urian Florez <andres.emb.sys@gmail.com>
---
 drivers/spi/spi-offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
index e674097bf3be..d336f4d228d5 100644
--- a/drivers/spi/spi-offload.c
+++ b/drivers/spi/spi-offload.c
@@ -297,7 +297,7 @@ int spi_offload_trigger_enable(struct spi_offload *offload,
 	if (trigger->ops->enable) {
 		ret = trigger->ops->enable(trigger, config);
 		if (ret) {
-			if (offload->ops->trigger_disable)
+			if (offload->ops && offload->ops->trigger_disable)
 				offload->ops->trigger_disable(offload);
 			return ret;
 		}
-- 
2.43.0


