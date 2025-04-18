Return-Path: <linux-spi+bounces-7684-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1342A93FEB
	for <lists+linux-spi@lfdr.de>; Sat, 19 Apr 2025 00:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987DF1B665F2
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 22:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13521241661;
	Fri, 18 Apr 2025 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG521lMX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81735233128
	for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 22:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745015955; cv=none; b=tSqVBEjqy2txz/yhwR7d3Yq/w85Yo0I9/Gekaw/n5VqY5erWItcAaGfsQCdMs8jX1Fb4+hDUVcwPx8kDQUdgvqOW+k2YeELPewkqZvjw3lyHJbjRK29Rb1akTKmjIdY6HVm3sLCGQm3idb1scEUphlBNqgIgW0UWvFpodSSKf80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745015955; c=relaxed/simple;
	bh=tklkS0cPrO9sPZbMRK5A6mjigmvMPbtlej1qarezBFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oXtDiiTxC0XnzoKfjk8VUth97LfwaCLexNap43EY383npQvBvSR3TJCmrRph4V/5fSziOOzBn8ImHFs0MtWsPIaGN3gEvpRT9vIxjkH0Wy2L6IZJHUAfa6Xr8Mn0adHkDu64ZC48Qx2RWDeSNDIIfU1kvZEi0RsYlDWF26d0vcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eG521lMX; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ff0c9d1761so20755557b3.1
        for <linux-spi@vger.kernel.org>; Fri, 18 Apr 2025 15:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745015952; x=1745620752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W5GhXqgKcWpJArYwrJW6cEhSHYi2oqhhybRAnDYZdGU=;
        b=eG521lMX7hgO7BUyopk3D+veup7D1flWVu/WOyBBJ4f86+F27tFzGjKNP2bY8E7DqP
         VrNuErl0JkelCmWlZk/KoTodzfuZHV6Dv3FPKBNgylhu1H4VqE/pGb4xqVaX9l4Byg7Y
         NYSlhLrms9X8RZHAQ2Iq3W2p60CCt4roadQgHHK127MGCblN+sxVfclZRzuWLAFvPRXz
         p0GbINBeZa/1d7S+JH9+mGBRmUVEMh3eknTc4L66kmNq9QMoInrgq/NbLu+i4LsnOo0K
         M2c013zhE43d9Qc03eE9qgrSONMow1ij7F2RGrhGAX3baFfZabihdkihbhGXiYdNDcTP
         igkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745015952; x=1745620752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5GhXqgKcWpJArYwrJW6cEhSHYi2oqhhybRAnDYZdGU=;
        b=cv93HeitQ+m1C7r5g4ZX3so3C3lmYt+s5FRXlncl5ANRa/MclpVBN+Uy1ngNAUKC+9
         NtW7UlGz0yNCQUTfvRNegG/lKW5GEujqbDVtWMYdDBSidqilzkSUdGr1N+e5AISz/MyA
         nr+0ec8hOVOMC2sGyu+iyY/GfFUynb4Y8v/3EbY4PoMnSWvjTZkPt7d2HXPAY/CneePT
         G7CWkKjK2Cnd2SDBiA8KPiNpw1aZUKqUVgfP31rKnQz3lXJvPkAv6Bo8hwvJVBfyW5g8
         bCAyQCj3Kim/g33cTNBg6Mg3F2wJCxIY3PBfY9yRbSzMYCPEVz+tYwsIt/4HfYCyLDwj
         xKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUdTsusFB5gRyB0rSVe/jzDxfdE3IfrdhkZVK43fFCO+S1pf1THWB+E+913ANwj3/uSibFZH9lWKE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Ov4JNU4/7pJ88rEwimGLQpeTMSXpDUNqzPHTLI2GYGNenTPU
	RypiwW2OZQMJZ5bJf5VEHmwtV94egKD2bhCB5CksEq3TyTINJhox
X-Gm-Gg: ASbGnct4XbqT7pfIZPLtOcUmuHHY0yCSNgL2Qb57Uc5r4xWAvSJlFBn/WgjnWaVFRQT
	6WBooqW6EaWU7f1pLBqbAEiKzJJms1YDkHXZbSJim0lbHJ5nxbAmlq7+ozY0r2/iSbHSWuDm2Ot
	flDErT3x5qRFGbKR0vhSj+ll8ApuPgYPneTLJDtWhB9Cb1wVfl52UvcXhrFIMN+bTwXdczIF/WL
	rgHFhsn5095eHKdm8js4c4ozYM9+UaHHN2Pe1Nexk62sgxy0gDA8aNdNzK5O3mZ6I4eeVDP3HvH
	nPuQie/bBIoZFimTL4NJevkRj36KcPFcDaI3nrM=
X-Google-Smtp-Source: AGHT+IEoTe+IXTTL83mRIDqKa9U6jQtyQCsu1go+Sv6krPR7z5q+6BEaGT9fQaERm8lL6E+KZH78FA==
X-Received: by 2002:a05:690c:6c91:b0:6f9:a062:2a06 with SMTP id 00721157ae682-706cccbe366mr63472387b3.8.1745015952340;
        Fri, 18 Apr 2025 15:39:12 -0700 (PDT)
Received: from velo.. ([191.156.36.61])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-706ca491c7fsm7281857b3.55.2025.04.18.15.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 15:39:12 -0700 (PDT)
From: Andres Urian Florez <andres.emb.sys@gmail.com>
To: dlechner@baylibre.com,
	broonie@kernel.org
Cc: Andres Urian Florez <andres.emb.sys@gmail.com>,
	skhan@linuxfoundation.org,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: offload: check for match callback when a trigger is being registered
Date: Fri, 18 Apr 2025 17:39:03 -0500
Message-ID: <20250418223905.45402-1-andres.emb.sys@gmail.com>
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


