Return-Path: <linux-spi+bounces-5209-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE19E99B2B6
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 11:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EE4B23280
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 09:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6B01581F8;
	Sat, 12 Oct 2024 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+9JsbE/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6840C155321;
	Sat, 12 Oct 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726872; cv=none; b=MmHDn3CecY8ewfZuamhb01VkCd+rKaNsijPD0NNdX8/U8yZFOt0AiPDqi9Xrcir6WysxVmgiCB71nyWHDxQtQeXkwkHWfKcDtejgoocRTgM0AcTkoBSN8Jf4lzAm55YbX+HV25r0oz6sK5s5Oot27UT4+WWnDZOXjoNrjYkrW9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726872; c=relaxed/simple;
	bh=tT90fDfKY662Oo3574ntryYhNPrGX12nSuc69yzLIig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eFOIhVAk9/HtwZYqYo9XAEh21MP7RreAc7bCXnHA1XvUlZ0/L57zh0sTxIA3WxC4XVOb5aUpbHctFq5omVE+POnV1+vjA87u8kuD7nfxPnyGWo7vpgicYpYAZL0pIDPSeebMwz9uzbHlWuP/3Vzbr4i3bEcMIyYGXSBVQyIcfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+9JsbE/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99ebb390a5so69441366b.1;
        Sat, 12 Oct 2024 02:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728726869; x=1729331669; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRAJK2lijZlZ7uqxAhRv6bavE6DAc/XMDZFicjzd2Mw=;
        b=O+9JsbE/OGT3Lo+fB5ktgV27knhSJs0Lwb7Rn7Ufn0RTkLOZHb9Op5zx90qjUNIRhe
         XKxpgC9OdUCUi9naDZXreyBwmGv8WeniaMX4oQrx/MAIMJ/KMKIx3bJg17AIPppHtS9k
         crlGdPolVYtgMJ6q1/EjvUiBWsIW79xiCN12O/B7cAGCQPsSJREU5sDVwkyBoyy0Fojk
         7+EISEQkyCk5zoFrayfSFFu9Fhf/aSN1frNpjaWXGTXq+sLal/axsAsF8DevFVtsPdsk
         xGcAu60RHbeF/R2LMRnj62YyU8Tj4cAeTW1FLy/YbrD3C/8yAEah8Oc8uZLBlsunOvEf
         eswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728726869; x=1729331669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRAJK2lijZlZ7uqxAhRv6bavE6DAc/XMDZFicjzd2Mw=;
        b=tqjWM7qPU0tjVlYGXJadvszLtEVoN8uq99cdbG2R4UtOhmige+j5iCIm/w8GV4jF5+
         OE9pMMJ3upoG6OlTqukmqLrdGOJh8Mae74yXOKs08WBPVmFD8h8PF2tmEpXqJ4iZFoT9
         IV+wSJK5CsVVJBUifdLbFnQ9YvoIPjboj2VB6RpW3ZzoaAoO+LqGVzilSOzcWBLWz8Ya
         0Y2Ew3jzkOxjNSJV5uTzUSSa1ooAvvsYlv+bsNi91zNpONIreEfgDlo5d2rhaDVWUlMG
         ZpkZ6VmPBUIympdv3uDdeleIVxwxHQJD8w1U+zYfZaoI9Jcx0aSBibRS6wl3rtfdV5Av
         cS0g==
X-Forwarded-Encrypted: i=1; AJvYcCV0Rom4199rknubye8K1DurvITc84H1GkBNEqJPbNcRB11F2m/LJfUs9RNbfDjbg3pqqE2d6RgEOywTaR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9UnQtPkPHG+J03D1dL1A6+iezBRyawBtrpMAtyv5sVpaNEyCZ
	ngFtLQrbPvPe56gmzLLUTsO5kxv5acdvwdr7L8UmLbJ8W6EPa9Vpaxn29M1ba4w=
X-Google-Smtp-Source: AGHT+IHWzyYyIAL16jaxtcVte9iq4246C5sBQphF02aft7y1/jpOQGJdIeLeIKYwtpignkTd3q54UQ==
X-Received: by 2002:a17:907:a0c9:b0:a99:ee23:dfb8 with SMTP id a640c23a62f3a-a99ee23e019mr106568766b.20.1728726868333;
        Sat, 12 Oct 2024 02:54:28 -0700 (PDT)
Received: from localhost (dslb-002-200-173-220.002.200.pools.vodafone-ip.de. [2.200.173.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f5ff0cf7sm14740766b.155.2024.10.12.02.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 02:54:27 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 12 Oct 2024 11:53:39 +0200
Subject: [PATCH 5/6] Revert "spi: Raise limit on number of chip selects"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-spi_multi_cs_cleanup-v1-5-dc491113880d@gmail.com>
References: <20241012-spi_multi_cs_cleanup-v1-0-dc491113880d@gmail.com>
In-Reply-To: <20241012-spi_multi_cs_cleanup-v1-0-dc491113880d@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Now that we removed the limit of chip selects for the controller, we can
reduce the amount of chip selects per device again to its original
value.

This reverts commit 2f8c7c3715f2c6fb51a4ecc0905c04dd78a3da29.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 include/linux/spi/spi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 77511c7d40df7085644cecaae325c982fb306afa..fe99f46c7d926eeb75398f4dddc5ef64d8f7736e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -21,7 +21,7 @@
 #include <uapi/linux/spi/spi.h>
 
 /* Max no. of CS supported per spi device */
-#define SPI_CS_CNT_MAX 16
+#define SPI_CS_CNT_MAX 4
 
 struct dma_chan;
 struct software_node;

-- 
2.43.0


