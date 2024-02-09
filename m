Return-Path: <linux-spi+bounces-1245-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A76684F803
	for <lists+linux-spi@lfdr.de>; Fri,  9 Feb 2024 15:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD861C227EB
	for <lists+linux-spi@lfdr.de>; Fri,  9 Feb 2024 14:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6066EB4E;
	Fri,  9 Feb 2024 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btQQG5m4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF2D4D112
	for <linux-spi@vger.kernel.org>; Fri,  9 Feb 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707490752; cv=none; b=iMlcLBJdrJpF9bMHbYC1S9G+6F1FFOl/w6shewRN2/7dt0EAyfVlk6ZQg+3B2LcGNOvSoFtgSPmsJU27fj1Nj9gwgpFw+YxPcz5g5CDGQdoFG0I0c073xCUH5vgPkQXH6zHb2cn5wwrFASV/UhqsMicEmuRj8lSvik/m7dL/j48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707490752; c=relaxed/simple;
	bh=AEJK5zOkkcHkdG8RCi4A9JEQpOzZPSqgi484cubkcJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UtazQnlU73m3copwn0xRx+wL4Avtqt4gGAL6VDilibHcJyImmB1+DTJSbgQ7aoFbZ7oSRgaR86bJ83cKGxGmwg0xiCS4ZZlhQ3qh74m+A2tQpO6N6o/ib74AYbVNbTzQQaEHhkjW1pgGgxrFyyJLHl561dN0+c24rGmaTv7Pk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btQQG5m4; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55fe4534e9bso1444357a12.0
        for <linux-spi@vger.kernel.org>; Fri, 09 Feb 2024 06:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707490749; x=1708095549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+0xXBtbgTuVg75XRZTNZe3JUN/p++sNEEGcA8qhq6Jo=;
        b=btQQG5m4+pmNTgpWpgFBdl6FoiOJjuA44p3ZUm27ZxU/Ifwi2ia8fs1ZEhEqkunjLh
         t9oVUVXdQxQKxCCyeUb3z643ctkLP83EMt6rYQe72NGarwRpMXYHye5BQF4/2oSBh7An
         7i3JqaSNUYr3wKD2XVTS0pWQLWB9wbUYm8QR+CZZsYniSFPGxdwUCnOqnRVpSaxaRU7N
         tenxc5IepwuX5jY3QlcqET+VffWBOkAE3+3ntnM2C+LREaGXMAQRDiesn40m85+wX1ny
         YgASuv2pAlO9bjU++DLS2kOJK7PU3GW4t3VA4Qpa3czWZotKMj8BxUKuGx03CAai1k/R
         ZzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707490749; x=1708095549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0xXBtbgTuVg75XRZTNZe3JUN/p++sNEEGcA8qhq6Jo=;
        b=pDGFVgDfF+GB/GoptglBWD7jrsMYqY/h7IKYx0YfNCcxA3ylb+R3XVOn0CpAWCoJf3
         vU6eb+g07TBNW0dAYSdqysjwUmnSiSFI1vXZn7Ujo0IX54b2rrdBeohVHFjR55KljIc2
         j9P2Iy1Jxsf+ffVCApMCLza8zwX9JYl4fU0rb2eBZ1s5orVi30o0oCEVdDW2XIlr8jr2
         4MK5wxyNud2CiLIfW8s2q8NlD6mt5WekJsZbL/TM7kqO29+7cz1mvSSd1BjYOiSap4If
         T+N3n6aHYNcLDjSc3JPesv2PkqZavfplOG4LHBDEynaY94yQTrzpghP6ROFgOji++TZs
         c0UA==
X-Gm-Message-State: AOJu0YwhV3YfJAMNyksFMtDQbsSO6q6LQ3RlMd0N4x9JZfA0Yr3BztYV
	K7fmJwWvth7xBUP+8Q+2hDP50Wb/S1gjpJ57DPNcVXsqjMaTFEaedlPnHdCY
X-Google-Smtp-Source: AGHT+IFnAc/9+UpFcfxUwqW7zoE/oLkdn+g37DQQGUukeygCLobGD9Oa/oRE9DlJexwVnL7XW9BjDA==
X-Received: by 2002:a05:6402:31e3:b0:55f:6fd:8ac1 with SMTP id dy3-20020a05640231e300b0055f06fd8ac1mr1546053edb.37.1707490748868;
        Fri, 09 Feb 2024 06:59:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUSyLdmusyQzJDzX19vZv6UaXjK04vLrv0tsNRkAL1PePcU3fK0Ite2Vwh6zX3Z88c2gwPA2yRQce0oVIjdnZrjrex3d4m9j8JG36PV3w==
Received: from shift.daheim (p200300d5ff2d6000aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff2d:6000:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id r21-20020aa7d595000000b005611917ebabsm859134edq.47.2024.02.09.06.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 06:59:08 -0800 (PST)
Received: from chuck by shift.daheim with local (Exim 4.97)
	(envelope-from <chuck@shift.daheim>)
	id 1rYSLM-00000004K1O-0uao;
	Fri, 09 Feb 2024 15:59:08 +0100
From: Christian Lamparter <chunkeey@gmail.com>
To: linux-spi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Mark Brown <broonie@kernel.org>
Subject: [PATCH v1] spi: spi-ppc4xx: include missing platform_device.h
Date: Fri,  9 Feb 2024 15:59:07 +0100
Message-ID: <3eb3f9c4407ba99d1cd275662081e46b9e839173.1707490664.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

the driver currently fails to compile on 6.8-rc3 due to:
| spi-ppc4xx.c: In function ‘spi_ppc4xx_of_probe’:
| @346:36: error: invalid use of undefined type ‘struct platform_device’
| 346 |         struct device_node *np = op->dev.of_node;
|     |                                    ^~
| ... (more similar errors)

it was working with 6.7. Looks like it only needed the include
and its compiling fine!

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/spi/spi-ppc4xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-ppc4xx.c b/drivers/spi/spi-ppc4xx.c
index 03aab661be9d..412d6e678224 100644
--- a/drivers/spi/spi-ppc4xx.c
+++ b/drivers/spi/spi-ppc4xx.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/wait.h>
+#include <linux/platform_device.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-- 
2.43.0


