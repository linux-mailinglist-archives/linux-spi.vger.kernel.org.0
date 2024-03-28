Return-Path: <linux-spi+bounces-1925-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDCC8804E9
	for <lists+linux-spi@lfdr.de>; Tue, 19 Mar 2024 19:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC4B1C20926
	for <lists+linux-spi@lfdr.de>; Tue, 19 Mar 2024 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB3037708;
	Tue, 19 Mar 2024 18:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mYipdIwP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699DC36120
	for <linux-spi@vger.kernel.org>; Tue, 19 Mar 2024 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873261; cv=none; b=cN54Xq3f7Sx+c4KAdxB1YO8LCXQKg8LkIc69ntKF7P8sg076uE9WXdbOPEadUu39oe0c4UeZccXw45dzXW8r06FXKF69YYjuzpa1zoWm6+37+MsnBbfYgoA1DhX5oPqHlUxs8oQuutGoqCKX7PPa/ZJ8cPiM4jBTxiEiVKkNMsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873261; c=relaxed/simple;
	bh=AOCZORgoJ7C9jn0a7E4jO0nFuKKTYWjWvdGanNlW3TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWj2VCnlCHa17HJbSa9WKK6he4EHporDlkMOWUvwU9HsE9j9rjqbspLY4bhMwCTqavKisryYGauCRv0rYWQY4k05KCzn55ht0FiWLo1g7XeyAE85ANBj365v86bx47gOFiOpDXrmDlE6djLxGiktcnGmLR3DkYux7sJSh+JiaPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mYipdIwP; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e6a070842aso685877a34.1
        for <linux-spi@vger.kernel.org>; Tue, 19 Mar 2024 11:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710873258; x=1711478058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JMCunOrrvuHT9lUNidkuFxv/99o3JWCs+pUE4M3Ym4A=;
        b=mYipdIwPpAa9tBYwg63/NVXe+W6tmcJ6K683elpwfcPr+7S6vjLTBgAWSKY3FuEnJc
         Si69YF7qcknnU32jUEWHfOIBe76gaGArD2dw7aIOe0Ce4kEzNfdvfvppsVzN6UVF2KHD
         mhz0pQLSfDhPzCNnBkGSC1qQZAQS5VEUHCwtn+rmiODYhNr5bqwjRA8Ko8DCI8JT20b9
         qd+KREt1I4M3ezszJ0HSCnscnXycVYB9GbKjlnmmRorijaeailI1wvU9AQv0t7/ldWSO
         IJP4XGX9MUYUkPULy/Z2y2fV4g6x73zVUsdS3E27Dyndd/V1/OmaxN5G4wjqFxXkwGEu
         ZhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710873258; x=1711478058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMCunOrrvuHT9lUNidkuFxv/99o3JWCs+pUE4M3Ym4A=;
        b=kdrsTpol27MCK5JDTO+FEhMHxkFBz2jJcoJdeAK7WoheTuNMhWAKeUDLLLmUfjeM9Q
         YUbxgIMUiFdoBqci3SZ7d1fZ+DCdzdr8WQRQry7zIFgoWvipmN+xE2uSWGQSA2mQGqBw
         hrB6tulQkbRLEiIpDxDPDSYb1u0DP1uRFdbwTapS99W7UiAYgBlK2qJKKkH0zYPf5q+e
         WJ2Y06yPL0pOU/f/SpFh5Qp9Z7Bu2DcH/U2dsb7yUSOytGkKVBV5kZPnhoBApFDypWi+
         cTHy2qbRDeGVe2Pq7r35h4bHltx+X30JUb7SiqicbwMeBNGvak+pNovERm/Y6GhoMDM/
         RlVw==
X-Forwarded-Encrypted: i=1; AJvYcCU69BQCrz1IWKlUDY1/bsSKzqca/umOF6nVD81TjbsQTYvBAYuKdAsMWlVWfi4KpVjZ5c7Xdkex9ZmXCDifmOspMH/QmJIeY9aj
X-Gm-Message-State: AOJu0YxplFZw0tGnwz9MRofDn6GIjvGki5Q+DzoTAnyr4BLBdpELpUFs
	iFe/RRRjRrbc7//99THdWcf26m4F+py8dlqlziNFDzCyTxyAxUTQqP0SeT8ey3w=
X-Google-Smtp-Source: AGHT+IGQyjgLHdHNEoImqpElpwjpRsWQc/yx4zVnNI2z658yNvjA2SPImFwda38BJhCoR5ARMwTfcQ==
X-Received: by 2002:a05:6830:d7:b0:6e5:3134:1108 with SMTP id x23-20020a05683000d700b006e531341108mr13951597oto.38.1710873258589;
        Tue, 19 Mar 2024 11:34:18 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id n5-20020a0568301e8500b006e53e81bab3sm2169804otr.14.2024.03.19.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:34:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: docs: spidev: fix echo command format
Date: Tue, 19 Mar 2024 13:33:42 -0500
Message-ID: <20240319183344.2106335-1-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The two example echo commands for binding the spidev driver were being
rendered as one line in the HTML output. This patch makes use of the
restructured text :: to format the commands as a code block instead
which preserves the line break.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/spi/spidev.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/spi/spidev.rst b/Documentation/spi/spidev.rst
index 369c657ba435..e08b301ad24a 100644
--- a/Documentation/spi/spidev.rst
+++ b/Documentation/spi/spidev.rst
@@ -61,7 +61,7 @@ the spidev driver failing to probe.
 
 Sysfs also supports userspace driven binding/unbinding of drivers to
 devices that do not bind automatically using one of the tables above.
-To make the spidev driver bind to such a device, use the following:
+To make the spidev driver bind to such a device, use the following::
 
     echo spidev > /sys/bus/spi/devices/spiB.C/driver_override
     echo spiB.C > /sys/bus/spi/drivers/spidev/bind
-- 
2.43.2


