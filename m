Return-Path: <linux-spi+bounces-7679-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DF4A93BD4
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 19:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534811B6038E
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 17:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AEC218E99;
	Fri, 18 Apr 2025 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPVn7Mzg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D592211488
	for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744996494; cv=none; b=T4wf+os2J99pw0w7Jy2HI6KZrOI1C2sGQxylpj8oX58qySsuZzedAj6/yYGifTSAS3F+62Z/nVtmyj82/GClKnZcUszIgdCA0UOzJlCQYigzLrWMNROYlykqWQNQoH275qEvH4695adiGj7KxupG+2W9ggeV0nAgS+kIJcTWNNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744996494; c=relaxed/simple;
	bh=gCqcyjk5eTEm7SdjDXcY84MK1gxM9EVji+5Cn80slas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/xbdOdC8cYCnrANiklYoviw+mqhACFW82EP7/dUrxExVxLRByocAZ8vnwbUdp6U0I1GQAAQJ2td/kVyKAM+YfmKcx0nRN/GlM7OdvuplPnwTDqk9vaxihTcIOoCrzt8ubFypMfIdNBLRbfRAVLOVcDx7+x9vpEUOwCx7etg+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPVn7Mzg; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e461015fbd4so1789409276.2
        for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 10:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744996491; x=1745601291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jY6atDzv19RvLV9eZAkYAmM7T2p6jzWpN8By3FtLwAo=;
        b=gPVn7MzgREyMUYynun3/I9QTgUp9fqzBdGbWRNiaolWbqp4FEQ+J68Tcqkna2qBkmj
         h62mGLU3bM+oqCV9i6ddHJvTajzA9KHCY9BT7piYgiWVY6exT9ShhGsMyJkcioOehzsq
         OfqLxGy9nXcb+epLg2d9wju7NLLMiI/kgjjCNBiiV9Vk9k3gUIuOFye3knDOvTex+RKa
         6ZrLHVR+WTh8spABn+pjvV525t2OXKe3ESA/xsrtgYSN2FQ0vyPVqASc9JuaI577eO6D
         vN4umIQK3kuMPiRj9fWjagtqMh/UPeUbuCRCgRL9JruEy91Qc8SyUrXBnnmUGFmLNDLN
         Favg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744996491; x=1745601291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jY6atDzv19RvLV9eZAkYAmM7T2p6jzWpN8By3FtLwAo=;
        b=rDrgCn34lBINx+v+xebN+KJsiAYWRcFBHRxZ2hUH8UOR1UaTmuhJY/Vr2KI3UG/wq3
         HwwTLmQL0fYUTslKUM84HnaMy8EwRuyqvouJqzfBWnS+nMXwN4TnzuwkL4adHrYiWkq6
         UlpLbykQ/yEECfJeRBK13GLgztlXSDPTAp87F1jWPnMVrurP0vraC0LmJMn77nLVWspe
         Af89QtjDl/9pEDb3LZ7p99z4ac6iLgmv9IumElyxo0agND81uGat+/SZMGV3ops9blv/
         /TgOZq5t+6A/POdHOr250h88zVcf7fONgEUjWNntjjBI7WIYkfam/pEycA6BaY8whB7v
         t4Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVaySy1UF8ipa3cEgRy3OnFEvrKcKtd87gUwTswZCGfRg54HE88zEZ/R06Sq/xAj+ypuA+xPdkGk0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4tAgJ9jxrOhuuhh0GkA/Vq0LPwXEjMvel3Tz2U+Y1KVylA1ek
	TGran6Z/rFtI5G49xzFC02FMjX/0YgmO72ZsW9qZoZGUG08mkPbM
X-Gm-Gg: ASbGncsbUel/OgpCOYzC/YXXiJVE6fisnRVbmTjUoyYcD9wrYA/UVIST0dmTvOTWxHm
	hAXI4cngsgqiPTR0Itp58vTVaMwVRNRgRkf78LruG0Xj+NbkYH2ZXSYjN25kPa59aM5SADbSkRP
	KvZwoFhQpiPueJoOlqbPHwoWKjwx1+VWlAHLfugdhOC1YIIp8XmXPQ/dtGYGaChR/wjbF4qIgw8
	YT0szel34T8fEBlEaaGlTDZS5XZWnM2sZ3CCfSZeVvwBIxPtqXC+ndS4jiy8fXZaSpfcgpKwAcD
	RpfmWyJVZol+WO7rsV/tEWSGGrifNKD75rJHyugatQ==
X-Google-Smtp-Source: AGHT+IFfR1QNkOJPs0M6dAbyMSunCMbSqFI1JmZ+J2snKkkqaD4sD6R/fEkgQ7YX9IFZnbV4VJpMTA==
X-Received: by 2002:a05:6902:2b8a:b0:e6d:f287:bf9 with SMTP id 3f1490d57ef6-e7297dee75dmr3816397276.22.1744996491448;
        Fri, 18 Apr 2025 10:14:51 -0700 (PDT)
Received: from velo.. ([152.203.179.108])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e729585aaaasm520520276.18.2025.04.18.10.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 10:14:51 -0700 (PDT)
From: Andres Urian Florez <andres.emb.sys@gmail.com>
To: dlechner@baylibre.com,
	broonie@kernel.org
Cc: Andres Urian Florez <andres.emb.sys@gmail.com>,
	skhan@linuxfoundation.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: offload: remove unnecessary check on trigger->ops
Date: Fri, 18 Apr 2025 12:14:24 -0500
Message-ID: <20250418171426.9868-1-andres.emb.sys@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Considering that trigger->ops = NULL happens only when the trigger is
being removed from the list, and at that point the operation is protected
with the spi_offload_triggers_lock, it is possible to remove the
!trigger->ops check because it will never be true in 
spi_offload_trigger_get()

Signed-off-by: Andres Urian Florez <andres.emb.sys@gmail.com>
---
 drivers/spi/spi-offload.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
index 6bad042fe437..c43264dc3900 100644
--- a/drivers/spi/spi-offload.c
+++ b/drivers/spi/spi-offload.c
@@ -183,9 +183,6 @@ static struct spi_offload_trigger
 
 	guard(mutex)(&trigger->lock);
 
-	if (!trigger->ops)
-		return ERR_PTR(-ENODEV);
-
 	if (trigger->ops->request) {
 		ret = trigger->ops->request(trigger, type, args->args, args->nargs);
 		if (ret)
-- 
2.43.0


