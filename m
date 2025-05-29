Return-Path: <linux-spi+bounces-8326-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81EBAC7E68
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 15:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A964E6C88
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 13:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6657221FCD;
	Thu, 29 May 2025 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYXPN8B8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9554C9D;
	Thu, 29 May 2025 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748524162; cv=none; b=EAILDMEreNAdEJs3lfCNfwvRs3wXzzv+k4pBfwemYyXRvljTLH6t7JRVmDlAYSpEILY0zzidkfZJuTfTAVLoN6rJZoantKG7x1A2OJCrjNHypz0xW/SU0cYXujTnw3aAxSNCeiQaBzKPQEV1GUPIatWBvK3ayOL9YRlXyAsTrTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748524162; c=relaxed/simple;
	bh=iFsFoWJDPszRgYwlJjS1T623zxqjCnINWiFqCzPhtTw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Utj6zgSCc4zMI5yT3AODDz8YU9fm24FCI5U8pSYAPN/z4l3DIQ6QocDl0OQ7VdeBnOYvsnwcSYzsWxp2EUD+HFtYjcCMEOSDldR7i1rn3zSnI/nFi1prsLSjXgdWjYzTRw7zXgmhTUnGOVkD3m1hHTsBCH/fg6l69EHOuGEGrxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYXPN8B8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so5242835e9.0;
        Thu, 29 May 2025 06:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748524159; x=1749128959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9v93JXeX/Cb91Hs6+qYd1epqJT3XwZK/5auQIPeqC5w=;
        b=dYXPN8B8ME2zXStoDWxGfqIzEknB4UOencOfFttK9GyitHOhrifGuI7SEgUNmtdyir
         Msfpw8ydCvdq0huRJfV5AriXNb0GwK2kJFwr2mWGGb9Ry/FBdDR4zQ1EdxLOJmmnuyPZ
         +y8xvc8g9TlNecSiE5VDtxNj+bLlJ3GpWEZAzIBWSg6hslP2NZsO73cBAAltDaoV5tiA
         EFEir5p6A6dMU+efipXGFvGOrpJtcNa9wuJmz18QdDDPD9D1eAgqcu0+FtH0C2leB9lf
         02Rc+lpH2ih6nPvzHX4pEp6RvDVlLt1TGrsvBV9SNt8E/DeRbS0L4+aF9/IORbBuvyn4
         Ldgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748524159; x=1749128959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9v93JXeX/Cb91Hs6+qYd1epqJT3XwZK/5auQIPeqC5w=;
        b=IPnmDrYbOOLhHhsYipmz+Dj3ygIxGh6ZpEzLQaNlqmCDKRh4bbOO5UbLpslrJOxetg
         W3yqJQ39XgyEr6yyrdNVXg1Zf8VAs+bO4Z/HbU7TRR3oyvFd32ROWaQTDH5vzu8tZeMB
         +1I0o3OOEd6M8Eyu0s/fcCxrr3WYpokJOOfciCoDajk9Pptz/gwqCBB7rSN07UXKZXkN
         iUg6scVDM9ypvDFdOusz48pPDlwMICO1hnn2crGWV1mk40FSCs1xAWmD1io7QUJeeWx1
         +u5qFv8dfuaiqGr414ET7Jo0dXdtdelclGIg2tkNJ0sDa2Q7+rOTDtMmvUGf5NhaM8g+
         6Hvg==
X-Forwarded-Encrypted: i=1; AJvYcCWt6WJQuDfUbmQqAC8/UvY2OOnPP9E9bvJ2J+sDTA0MpNrurmOUrP5Sd7U0ZmbiUGwrV79K56Oze2Hl@vger.kernel.org, AJvYcCXYmiGyRY+/84UV7/PjjrtpG9ZRyKG9BtMYDtwF+3S1XkZ/QlFbHGVJcoanT3MUPsBNezFyX8VUYvksjBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCSWFM1QUw3mNIvLK0xkaBSu6BIPjmW6D52WItscFU0h9bzHOd
	+u5yE1WLYZ3XaBgeuXnDCi1ko+Wz2Gfdy+5Zwt9EiVA3j0wEReTpVGpN
X-Gm-Gg: ASbGncux5y1oWIJ49xw68mmsOohNc2hgVLRRb28NzviCGvwtKqLdkV3f7gGRpGCXkF0
	B6ZUDbMN1nv0LhS650ns8uv9hsAeNBqpNiPw80trajTGz2MZvE1q2QR58iRgbgRu6V9IRxi4z7X
	uZPkhBs9NKdKDedrz1PYAQiVBgsJ5+zxfUh3uY6CaPG85xrGOj2FRJtgvVbKztrvdIDvFugi3FO
	JzZawlcCoKVNmv9DGWsncWwcqrc+J5DE4zMgcOGkKXVYla54hUaCQqz6FzjmE6PYEWooH2pz446
	4IHgckRt97umu9o++w8HbwWl8N/vKNeIwtq5/NzKc4P1bKdOAuB3pXHgWhX5aV0rJEJr4HPw7dt
	ZLYmq0jp1Pbh7T6nvM2QKJLBs7e8IL2EYQPnrz4EqYOsRIJUh+F4I
X-Google-Smtp-Source: AGHT+IFMlVFp9JJmJQoOdFmhaiqLRRSJuNEy/lETslEcgIvcH7geCRZVSLq096M8YlfYTTJQxQaQTQ==
X-Received: by 2002:a05:600c:4f46:b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-450d06bdfc7mr18716535e9.31.1748524159042;
        Thu, 29 May 2025 06:09:19 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc67933sm19439755e9.32.2025.05.29.06.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 06:09:18 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: dgcbueu@gmail.com,
	florian.fainelli@broadcom.com,
	william.zhang@broadcom.com,
	kursad.oney@broadcom.com,
	jonas.gorski@gmail.com,
	bcm-kernel-feedback-list@broadcom.com,
	broonie@kernel.org,
	p.zabel@pengutronix.de,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH] spi: bcm63xx: fix shared reset
Date: Thu, 29 May 2025 15:09:13 +0200
Message-Id: <20250529130915.2519590-1-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some bmips SoCs (bcm6362, bcm63268) share the same SPI reset for both SPI and
HSSPI controllers, so reset shouldn't be exclusive.

Álvaro Fernández Rojas (2):
  spi: bcm63xx-spi: fix shared reset
  spi: bcm63xx-hsspi: fix shared reset

 drivers/spi/spi-bcm63xx-hsspi.c | 2 +-
 drivers/spi/spi-bcm63xx.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.5


