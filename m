Return-Path: <linux-spi+bounces-11669-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2CAC944C5
	for <lists+linux-spi@lfdr.de>; Sat, 29 Nov 2025 18:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE073A836D
	for <lists+linux-spi@lfdr.de>; Sat, 29 Nov 2025 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D663112B2;
	Sat, 29 Nov 2025 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Pu/IOCbL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230713101DE
	for <linux-spi@vger.kernel.org>; Sat, 29 Nov 2025 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764435520; cv=none; b=nA80XJb/ktRLyZoWh5cK+Mzw/MymmZq9gRk/cIwna7G5B1OPu9vLOz8qOW1Okke3o7c8UC2WFJQ4+Ympw7V4ivgs0bAUYTC0TDahcNSyN2mIGqB1KGHD2zhHOS+1uGpTNDS7xJuZjE3wgUplo9oqmGKBdKTa9LK6w1Xm5Lo71VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764435520; c=relaxed/simple;
	bh=AVA5GFVBkRs1wbRpAiu51ZHKLu14kC8JNNO4YtqCsQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MztLdVPnyfghX6Edo8MsaRtiO73Q7ktQzYNHaSnUwvI6sNvLS8Am1PTpFCKmNZvyHkHEbAIsq4Xij80MEjnjVzzF5E3HeItMWRG6EAUu9AQn7qX1SpU0IxBjOHtDBd2Eurd+qmruvkksrxnLoC8ydyAgePnuYxwrxdpToDw/41c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Pu/IOCbL; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so5392990a12.1
        for <linux-spi@vger.kernel.org>; Sat, 29 Nov 2025 08:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764435516; x=1765040316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yIYJ4hsA2H8VindlpqoF2Djje2uUDv7uh8NHitowKg=;
        b=Pu/IOCbL47hYyLyqpAIALYv0djp084094+vFEuHV9/KoMVtu/Sjg7YVkUM9QfWxbaQ
         2aiMX62TDjZ4Zsa1pZixJyxk35BVL3LIozLe9XbV0TzdUqBHT1JdCsjpFWGXWc/p1HW8
         ZVK7Ehbpe4tPTJyVApqAKsq7c6RDX5tjSxI0EYVFD/HZGHk5R0QOEkA9GCbig65dxE8D
         u4z6a9jRMlgdlAj6P/RVWw+dT7SIWNDXY3ePpACG764MwY03Q1VglAR6Iz1FW3PaBST8
         j0qnqZHRWmThzhzSQJHo5/l8XqM+R21f/MzVphe4o924/hmM80exh8TSfIkYI8WlJsDx
         KzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764435516; x=1765040316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8yIYJ4hsA2H8VindlpqoF2Djje2uUDv7uh8NHitowKg=;
        b=uv6kSbMrUzBmGo0jvHLvMBFNnGovX5bY44rv8Qh+3FMhczyQsLuZPewAPTAC5gjpCo
         kcikLt7xQWgLPjTSp5apmVyYc4FsH3H4QJzxkQhagnZD3zUAAO6LKAxEHNE9c8mSE87y
         vGAnWrJGBx4RSbPLM6mO2QXCIGe/6fb9jS4CV5v9gyBltNSqffw4qk0EKGaQLBh4gU97
         HfTh8HxZgTifLt8L3H7c/RnY109t0M/LbpQvVAMYwm0OKEligeZSRZwTFHUtVZ5evYPG
         UaYASFdPgHoKkkYEe77S0AvjVuLdsKVCLPk4TJbazjAscpP3xS5sH0eIstvorBOxJcOm
         i0XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLf/sERUebzTSvYkN2HMygdyqzq5OThP1J5UgNvLqKinvNbECBwozsTy499izshP8WF3XphddPqn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuFecH8j4GqA1elHr9ULiVfx5D8n5CXoWAKtF5V3KbFvh+FD4V
	FgIFyDc2JWRFmTFJR6r1+gTI6GEVdRjcOjmsB8VniXucIFbZk176YVbpnbQAHMGs7Ac=
X-Gm-Gg: ASbGncsOtdK6BduwhZdpnzAwF+mYaJ++lDvBag334XUdBpI6XfES6Evqd3CguWwgGTL
	Be7f8Dudhvh/VWnJJNxZfd3LnKsMDbsUHnqlund9DU7/Gd5ULci4Rxi9lpC1EYal4fPTT00ijHw
	MIM/LU3lLV1eqP+NU5lmSNSTWirbvSgPvRFi5uPcynxa46jIm4FzHN89SwFfKiunaYQ9ncBlUhW
	5F8JvqM+CtebYnDa7Qze84il9HVmNB/NZyWcvTphKgg6SAF45kmZsihIui4BXj4SjG7KGUKqb8c
	PVgvtCJmsplf8noj7OCEYxG/FL7GceLeFGQdYGymSH1KdwBxQPByDN1sIGWjMDoBLF0AFvUYFXl
	MpCXvphAQhOsiHFh2oHCOHh1x0nhHWuQaKqiTNmp4Pkzf6UaqA542hxcc9NciuiYi1iDyHmtzv7
	Feg58tHFvi6tKKSR5V
X-Google-Smtp-Source: AGHT+IGIuMdvH/1tKC0GuiX7Gt1dCZsROagA1pC0AM3CevNgSG+kcT21e2Bdl7GfR8yr/m+sJVrOFQ==
X-Received: by 2002:a05:6402:1471:b0:640:9993:3cb8 with SMTP id 4fb4d7f45d1cf-64555b86c99mr32037434a12.5.1764435516385;
        Sat, 29 Nov 2025 08:58:36 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6475104fd7asm7137690a12.23.2025.11.29.08.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 08:58:35 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Eddie James <eajames@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>
Cc: Ninad Palsule <ninad@linux.ibm.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 05/12] spi: fsi: Drop assigning fsi bus
Date: Sat, 29 Nov 2025 17:57:41 +0100
Message-ID:  <948f0de217633462f79a3fe2110f8f168f19dde6.1764434226.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1764434226.git.ukleinek@kernel.org>
References: <cover.1764434226.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=690; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=AVA5GFVBkRs1wbRpAiu51ZHKLu14kC8JNNO4YtqCsQg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpKyYPHjAHhF+ULcOvvkqkGdGH717OEbRZMKbee Nkfi6RhElGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaSsmDwAKCRCPgPtYfRL+ TtsBB/9LWPveK4RW7ktobXwpQpv25VxzxhtLIr6rz4CbJG89rgYhWagqevuJ0njOqFm9bYv+RaM pKrfCvwrv0eRd8YdPtU1nksoMOiXLXZ/AYmE0fdrhpoSTblASkWmXifoSqJbpxu1c1njk12e0fc o15kc+tqCK6cJ7mnmfsCJsrO4YZmqVnAVRgY1Q8htkCx9HdCiytvjDI5BdBsYhsimijY8FtUe+y RoR1BeJ0xFXvfi910r1fySZXuGy/BNuqcx/kuJkbjqN8olbBmphjwYl9M46l65QX0DDLmQLnegf 4zbSJSp0VX45LtXHfh9HOe5sZwx7+zXRmPrVAA9MsW2wAKm5
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Since commit FIXME ("fsi: Assign driver's bus in fsi_driver_register()")
module_fsi_driver() cares about assigning the driver's bus member. Drop the
explicit driver specific assignment.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/spi/spi-fsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index e01c63d23b64..f9c15b99dba5 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -595,7 +595,6 @@ static struct fsi_driver fsi_spi_driver = {
 	.id_table = fsi_spi_ids,
 	.drv = {
 		.name = "spi-fsi",
-		.bus = &fsi_bus_type,
 		.probe = fsi_spi_probe,
 	},
 };
-- 
2.47.3


