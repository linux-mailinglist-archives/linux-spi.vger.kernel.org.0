Return-Path: <linux-spi+bounces-7659-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A79A92E3C
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 01:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3C31B634A8
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 23:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C95A221DA0;
	Thu, 17 Apr 2025 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7OjphPn"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958CC22171B
	for <linux-spi@vger.kernel.org>; Thu, 17 Apr 2025 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932210; cv=none; b=lYopvFNEhrYu2Rev7vOFsCW8yKVMtPvIbgO8n4SeBkEacj5Fkae1miIkZt5eGbEFxsPv885DTlNb8Tm6Ccu895CCxXfxAGdGwtJCmzx+MXqdmp15mF/0g1RsOlY0n4JhoQgA1+ffkNpDZ+GJJ8I0AVxRul7H2SemZaqeDFJVBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932210; c=relaxed/simple;
	bh=afbcolN/NnSMhkEXGFjDgWUN+hg0g5nQbUl+GSv6QHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hC8whuVAhO2AgMoCTs63nyg8eJxb8pdX9M0rkfEduMYkagjkFBfFywWIpUvozR9d7W1wpQnfkMsTV9IW5qkTXdxqVqM35YKA2AaimNMZa1UuXye9WaQAIgmQY5DPqxxR/iIvtO63SVjs/JHnK/UrxYXm7oe0w+TPZ0/cK9P8Hcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7OjphPn; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6f6ca9a3425so15385507b3.2
        for <linux-spi@vger.kernel.org>; Thu, 17 Apr 2025 16:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744932207; x=1745537007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgecd9Vto/BwQeM5ZGLJYjncx9NHH+e3lpjYGSyj+JM=;
        b=a7OjphPnKJKf5yg8nKxIF+iS1WvPtXgWjYp4GTxG+TqNaJPP0vdUJG9RtGbfZ43Cjw
         NGuiBTFnXRjKqG6xNMg+mMYiUvfkHkFzvbq3s5hidT9lZi7iZUO0DzsaLgSpp9igh/+d
         ARDNhZBq7WnVohVxUEMBi5ncnvR17GRJ6rXpcnLNvKmHhZJYdT0sLoY6O6Q4QKICjapf
         298bdBsoqWS9Z/OmAMBSwgHRmlaWkKyAce9CyJ5Iu/Vsh5oVh/MmBkzeCwSTzis7fdvl
         pzQ8DhdH86jO9lXX7W0y2lnsLp3s6Q7dpEfWGl7O9Xs8XJp14oQDByvvY9qcAHXw+DWM
         Nvlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744932207; x=1745537007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgecd9Vto/BwQeM5ZGLJYjncx9NHH+e3lpjYGSyj+JM=;
        b=Hz6/SzP4lByjssRvUR6ENFH/yMAA2E9Z3ae5Nmt/HPzOPIU65EcWOUlCdy1gZFPixo
         c6qpQOBeYghb2h2B1XuGw4AVB+dvV6QxsF/RYG4qRH6XNKF4VCRD3YrQuAxcZc2LzhTZ
         zrFNmRqLvajyNiG57ytsICmF9U0M2uCsIYVyvW3l1xnWJP8xlaIafi+shbcFkqSCU/vw
         WDYB6wBBWvpjrmAjoisqhPcrBExkzk7u1foP2QXAMJYu4JB8A3VCr5+EDfe0obufrUek
         fmKRYkm+ZUKJgEPg9cC0dI4jOZ0YA/Pefhz6LAnJJndW1iAX9dJ/fm7wZeYxzESUorTM
         YEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXp3yyBpuBQ775Cxy4N6XTDMPusep+nkvs+i8/4wNDOh4sT4wbOf/kmvknbM3QvtFSsDItpTD8qko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOvN/ysyfvtqV4lKyoPOs1WaKeDFk15gWnN8zezfVbcFQmPX5Q
	LURU25QABKDweoy4mu7sI2tILIIrDOuu600/39l9SiRgiLqQD4jY
X-Gm-Gg: ASbGncseSyA5iZVxP4kQoMxH6g1mzD4wZVT++FDJtgHnG7BSCwOQe4mVPe52CUexUI7
	O3SCjW1aM+6ntMLI+jn+DYT772pCGiPBNmprayj2aUJVPRaRcjQ+5Pz8L32JROTfkWLzgzpaoY5
	6j5fxebZIt3sGgjkzW+ARcoRxaG0B3qoGYGMfzzoMHpvSc0W0wr5FjngzH9TL8oBICXJoksisn3
	zjSOv10Vd8wpRFMf/zf2YM/z30Mf+n95Rd6IUMGupF+PD370jSGHYd+TweLlO5bu5DI/IF8lbJ3
	q/Q7Bh3pBTUxDh4iIyafozcjjw5bViaD2KtwH7jXSg==
X-Google-Smtp-Source: AGHT+IHvnBJ56dqVL1uMAHSxKg2j6R7EAGQKUrCW4wp6IeEzAADJ8Dfk1yov8kyiql0J/nAf6POIkw==
X-Received: by 2002:a05:690c:6ac5:b0:6ef:652b:91cf with SMTP id 00721157ae682-706ccde3cc1mr11042947b3.27.1744932207450;
        Thu, 17 Apr 2025 16:23:27 -0700 (PDT)
Received: from velo.. ([152.203.179.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-706ca32c31dsm2314067b3.0.2025.04.17.16.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 16:23:27 -0700 (PDT)
From: Andres Urian Florez <andres.emb.sys@gmail.com>
To: dlechner@baylibre.com,
	broonie@kernel.org
Cc: Andres Urian Florez <andres.emb.sys@gmail.com>,
	skhan@linuxfoundation.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: offload: check ops and match pointers before use
Date: Thu, 17 Apr 2025 18:23:16 -0500
Message-ID: <20250417232319.384094-1-andres.emb.sys@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before checking if one of the triggers matches, check if 'ops' and 'match'
exist

Signed-off-by: Andres Urian Florez <andres.emb.sys@gmail.com>
---
 drivers/spi/spi-offload.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
index 6bad042fe437..fcb226887488 100644
--- a/drivers/spi/spi-offload.c
+++ b/drivers/spi/spi-offload.c
@@ -173,7 +173,9 @@ static struct spi_offload_trigger
 		if (trigger->fwnode != args->fwnode)
 			continue;
 
-		match = trigger->ops->match(trigger, type, args->args, args->nargs);
+		if (trigger->ops && trigger->ops->match)
+			match = trigger->ops->match(trigger, type, args->args, args->nargs);
+
 		if (match)
 			break;
 	}
-- 
2.43.0


