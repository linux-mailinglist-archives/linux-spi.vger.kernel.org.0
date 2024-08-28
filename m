Return-Path: <linux-spi+bounces-4360-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098A0962F23
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 20:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81992827DD
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FA51A4F0F;
	Wed, 28 Aug 2024 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZPcQ+Yf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3414EC47;
	Wed, 28 Aug 2024 18:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868077; cv=none; b=E+5Rn5l4c2S1NY7UafZ/mqQL6Gz8zzim6pzkyoQc2KyE1A0OzDSxtw/jcvbHSvY42HzI+aPEkQUeZrT04W9+U9xK/wokesY/4W0uJZGLD6lwOrkXI4UX4VtNdIRb8myyM4HmEyqrOA778+DtzDEY3dkJXg3GtkPKk2ipn4nyjig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868077; c=relaxed/simple;
	bh=KQoVU0ohfoUcNvHfCK/fBDoRXiT+Jb90mxBNFE81rNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GW1gwdahZYI/MahBW2/+sG6mASCaeJ/fjrwQmjpRSEXPKneNSq5xsDduIzxtN9KGZp5ZtRp4Ya6qgaf6Hxe9c5BsoRPLcjRIyl1rCry2ym9DhAjKzvoRtFpvwQSD4Lqe106Cwx/FOr6IImcJx6ES7oJTaD6AfbDPsRZKjrj8giM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZPcQ+Yf; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7143185edf2so5854261b3a.0;
        Wed, 28 Aug 2024 11:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724868076; x=1725472876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YwO1tVhas9mZORSVkPcYgJoFV2fs+6URakIgFUk7sX4=;
        b=bZPcQ+YfLHBjLpbvYyqjJKIJeMMS1eXNTH5CYfsG8IKrNF1qldU3cWs1M5jlkYc1tE
         3Bo+hjlt8wsIefC3pqbiZ7gctdYywOv+NWYUlJdIhWru5zq53cMVa+p0+gN0rmqtLF4s
         k58ble3+go6MkBQVrCaN93JwGTblBqGJxE3YDBP1cQ/qnzNMKVHuyxY1Imt1aSdJgubl
         OL/FiwBWJZWOmx/C5ZZPyXWzu1wdXPQgSCOhAYKPoXdhsyr5PMoS3B7vFerwXz1GVkja
         ZH9iYb4EuB2PKZNRBIBAJ6n0MAFCEBsjkxtUtfigCaVasZWyP+xRK2QquiRhFUT/nsoh
         HRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724868076; x=1725472876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwO1tVhas9mZORSVkPcYgJoFV2fs+6URakIgFUk7sX4=;
        b=N3X1UEOEQUoChHdZ7vGSlk/zQsleBJB4LmXsf94510DzZsL4y/toA/9AjVWekRO3fi
         KAhjfYrNNipNOmbbU+bINTsZXUzdJa6F9FddQGGM2U+1WFKoZKxZ/Wud31HaAzdjdL6s
         NvlHPIkAyihNrDAqM09IrtEB8nEidH68SgK3YdumsY32ZpQlOdjIVLIjREx9Ea2EUgii
         a1FiBFsTItoeSbSmTLiTxh4/+FHDa9GcoEvJI+Kce9OFXgyZXob/GF2CksHh/h9qrBjo
         +OJV6vkp7+qJ4hPlsQupJgL2BvcXp1Zd+bEXZhz+/t+lOWAFz6Lp1xzJJkd4zWruFMXg
         uP2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXieP3Wukf8t1c14L1WGEDF/1OqanXY/G9x8kzrFZFUcxWT7Sbbk29LS0zU4eSJzukTllEcLtpLXXHJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzTmDTOdkWka7YRPynKprZjLtL9CkcUuRvjqW8mw6AFfxJr33Fj
	pxXGHUrRTW6kKbckPtkdsfjDwJ22LKhjDbtJ/iW+wsi6aid79dU/
X-Google-Smtp-Source: AGHT+IGZe7JIGsLE4aR1OrNxkm4LBaa7dLfetL/m/nucpE6rqmJWf1USTSzPH0YjvsyjuK6svnI1NQ==
X-Received: by 2002:a05:6a20:cd0e:b0:1ca:c673:9793 with SMTP id adf61e73a8af0-1cce1027d15mr129193637.23.1724868075718;
        Wed, 28 Aug 2024 11:01:15 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:4b3a:557e:6b5b:dbdc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143434294asm10300127b3a.216.2024.08.28.11.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:01:14 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	otavio.salvador@ossystems.com.br,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH RESEND v2 1/3] dt-bindings: trivial-devices: Document elgin,jg10309-01
Date: Wed, 28 Aug 2024 15:00:55 -0300
Message-Id: <20240828180057.3167190-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
The marking on the LCD is JG10309-01.

Add an entry for the "elgin,jg10309-01" compatible string.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
---
Changes since v1:
- Use a more specific compatible string. (Conor)

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 7913ca9b6b54..49dee2a1f6b4 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -110,6 +110,8 @@ properties:
           - domintech,dmard09
             # DMARD10: 3-axis Accelerometer
           - domintech,dmard10
+            # Elgin SPI-controlled LCD
+          - elgin,jg10309-01
             # MMA7660FC: 3-Axis Orientation/Motion Detection Sensor
           - fsl,mma7660
             # MMA8450Q: Xtrinsic Low-power, 3-axis Xtrinsic Accelerometer
-- 
2.34.1


