Return-Path: <linux-spi+bounces-7686-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2236A9400B
	for <lists+linux-spi@lfdr.de>; Sat, 19 Apr 2025 00:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CB711B67F71
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 22:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E4B2080DC;
	Fri, 18 Apr 2025 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgrWcWDa"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110C125335D
	for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 22:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016488; cv=none; b=buRbWmDju/fZBUgrwGlVTyHmaRJhvaGQIY1VPbgX74OGtRIWvl46/9iWi41m0YxH6bjpfb+e814C+wDKD3g+p+QNJRhSBYXPzZkwPe1IDS0VYlgE9gs8cn/FiVpsfwC57HTd6sk0zM7x0WJncZhiQjAe5xK90aCJOmIOyGFmkE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016488; c=relaxed/simple;
	bh=tklkS0cPrO9sPZbMRK5A6mjigmvMPbtlej1qarezBFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=npCV7X4kvx0wtL2X5heR7xwvV/19czqjYQXz0SCyw2OX+AyT5sF90m7sn9AgpVMKwtsHw1Fb5b6Ajc/wUQTTv3WLnv3ENUyHBlZQrH+m6TacHhl0oYUPJ3/irt4aAqv+CAgrB8koOuWH2UHaE0xEeVeBt/hkFZ2OnsflN2HLwzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgrWcWDa; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-706cb438584so11684007b3.0
        for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 15:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745016486; x=1745621286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W5GhXqgKcWpJArYwrJW6cEhSHYi2oqhhybRAnDYZdGU=;
        b=RgrWcWDaRYd0/UaS+9A1sUqywciX/HpYp9RJwsvPLjMb+9Rhbp9yBnwxeeEm9S3cQ7
         AozjCrudsJSiIbrm1rsDkmCIrSK0DDY5NxVzo9mWgaZivKHFw6vfLg5YsD5qvzSd2E4p
         4+6x/3Vcp4hszfzRH03+Of+BCn/sDiksFZsP/XdMVk92MHLN39rTP985Frghni8Acg0S
         nV52F9xKmfh6UeGK614U3J3onpGGeMX1KJ9tuhfsJ2sO2sP+MTsIeAveq8t3+0W4jcfH
         fOqVeS824g+Yby9xeB4lstWIv8BhYmxrjeGcGvIteEfYKZZ1AYKzkEyl4ANfJzDocjyU
         Noyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745016486; x=1745621286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5GhXqgKcWpJArYwrJW6cEhSHYi2oqhhybRAnDYZdGU=;
        b=loR2+Is5Gv8F91a60lZuYLt45m7TGCVaxHzHksr3SoBfMpV3nlNE7Bik3p/AGYIQ9n
         z1y+1DVn7sN35JznPthuViaSZtAnhhiclIvx7rmaF7zsxl/L5Hf6fQ5SrTJIjnMJq7WV
         Q7j4tFa9IzY4vmH/EggnR0w8jkWJ1ScLBSUWM+GJVhzbQNz8Fn7ew4PEw6Xh1b48lc9r
         d4Ig3IMU8X719PMIVvxDslHD2byXicHIGyeVrH6REkn9+6jutjx88ZyXO4iyzWjh3hwT
         8ypVWn8kcu89nNt7C5Pr8EiIAqf2EpOX0w52S9WYCG9O1CgajhS8he1pRYMkAgxUbA9D
         36gg==
X-Forwarded-Encrypted: i=1; AJvYcCVCSl+0tWCzukkpd894T7l+ji7H4hwbSYOlC+0CDrhwmq4YQTuottp+qxgN3cNA4HMhpL3igrhqQ5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPJclTjIWB5z0fNmE/yK8PfcQLVwkSYw94o1yMhP5VCALGT+VN
	V0FZGMBhM/2xe7ui2IlN6jdPmDTZP8f1Jt6DRYHIo7oLbKJxn2sS
X-Gm-Gg: ASbGncszvm+lIPJfRYOCqS8Q0QGaTTuJf20dJn/fDa1CdfAO8EGwRh3WcFhvBWNxwjI
	DOsnByo8YdUpSc3GIh0mNHHWvR/KUZN+21ldBOjbN8npMb96ux8fUf4iElDIzu6rx+JbBCVintb
	kP+48cm0W9HqgWxyUlqwTSn9qUlVX3020WTCrFWfjSK51Ac1MpvgXmUOCrSjI3cRqfYcFCf45je
	j1flaYoOCJz/DNTCEGxVRW4sPDo9J9TQYf0MHVjHagph7S0Dojome0qdsWBfswu+jRDz0Toy54+
	H5voJT7erhkG8E8bnDWQfneyJT9GupA8HgC4eQ8=
X-Google-Smtp-Source: AGHT+IFsdL6/bqbuUqpeadlMC/Mpz3uVTptFEtyhM/isNZPX9U/ZPtpYdbNXE2nVqsdh1Wn9dFeMLw==
X-Received: by 2002:a05:690c:6e04:b0:703:ace3:150a with SMTP id 00721157ae682-706cce12249mr65449887b3.34.1745016485988;
        Fri, 18 Apr 2025 15:48:05 -0700 (PDT)
Received: from velo.. ([191.156.36.61])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-706ca491c8bsm7335357b3.56.2025.04.18.15.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 15:48:05 -0700 (PDT)
From: Andres Urian Florez <andres.emb.sys@gmail.com>
To: dlechner@baylibre.com,
	broonie@kernel.org
Cc: Andres Urian Florez <andres.emb.sys@gmail.com>,
	skhan@linuxfoundation.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v2] spi: offload: check for match callback when a trigger is being registered
Date: Fri, 18 Apr 2025 17:47:49 -0500
Message-ID: <20250418224750.46219-1-andres.emb.sys@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make match a required callback when a new trigger is being registered,
this allows that other functions like spi_offload_trigger_get() could
safely invoke the callback when it is required

In v2:
- improve readability of the condition

Signed-off-by: Andres Urian Florez <andres.emb.sys@gmail.com>
---
 drivers/spi/spi-offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
index 6bad042fe437..21a0f3a3a176 100644
--- a/drivers/spi/spi-offload.c
+++ b/drivers/spi/spi-offload.c
@@ -434,7 +434,7 @@ int devm_spi_offload_trigger_register(struct device *dev,
 {
 	struct spi_offload_trigger *trigger;
 
-	if (!info->fwnode || !info->ops)
+	if (!info->fwnode || !info->ops || !info->ops->match)
 		return -EINVAL;
 
 	trigger = kzalloc(sizeof(*trigger), GFP_KERNEL);
-- 
2.43.0


