Return-Path: <linux-spi+bounces-6810-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06773A34F8D
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 21:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E263ABEAD
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 20:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB432661AC;
	Thu, 13 Feb 2025 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFJ/tySY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1B224BC16;
	Thu, 13 Feb 2025 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479264; cv=none; b=Pg7cCNgiFNSm2DxjMsM7ix3Mv5zbYt0oXsHYhdS6hxGZyBRdTQd97w40MPkx5oYL0oisYZxqt8yjxYCEImJLsZh+NOaBPPtAdMkdSPL5I8yUQnYyjWOSCXqtmNO9TH5XfPaK1Zn3olBlMZzhnB9tdAt2v0PoBP+/02Mc84ihPOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479264; c=relaxed/simple;
	bh=hV2Mmn9ZeyL+YtYin2TVesMIGQS2prpGiT55D8OAp9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KcZDYx9Cyj4qHphaWF3EHtjjjGX38IbefDJxrg7XFblvdq0gdy7K7iUm87T8iuh8H7MXO2sKOf8b3LWDk9nZa0niAvrevtJ431DeNDKgY0ReIGh7/8gUrcl4N38JWBQ34GBPqBeldHd5JWjRP0+1XtaYdCqO319QdIGB0ft8jdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFJ/tySY; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5203d50ade0so297248e0c.0;
        Thu, 13 Feb 2025 12:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739479261; x=1740084061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bEraBi59wANcLZn1tO53PfWT2ziVOrD3fPU9kZezwl8=;
        b=bFJ/tySYyprK/zEzPwtHWwLgogrhYnjK/Qy4fgyAfwsT0oLZhi2BUFlZfOAnunPIXZ
         zzqhSeK2mJozdDyErl6oGvtuvluGCXaKk5pVaBUD0UH+p+PiZOd2WWhKhOzd9EDjG8gA
         YlfSMGgtH0biZvzxUImvgFh5XHInMJXaOt0TjlyXgA2kK5Fp+5pHUE17Ov31ZzH8eWmf
         SDcwIROAfUge3pXcClOlqsmZB47NukKzfn2VqeSm/na87vT/cLrKEZJMbJMjw8Kj3HGh
         u53WbOk9MwLogQdmi3ZDdQBCA41uwjhWij+rRzAWlbrjF24IX5OwgDi/JlyOVsGDBnyA
         It7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739479261; x=1740084061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEraBi59wANcLZn1tO53PfWT2ziVOrD3fPU9kZezwl8=;
        b=gvLJFHhQSpyrjKV+IRoJ/sH1vyyY3SYtmfjS26vwTn6bo/z3Mw/BnRDqxWKSshp+Ew
         rLxBgJxRKQzXpZLKPE0f9lj23FbvgSPiWl4w/6BJnFvThGUT49Yo7JIEWpAUsRDGGuFL
         7+SB6LXq8WkeP5+xHQp4r2NYpA9Fiz94a43VKbCMnxfmr8ocEUFuusCd2djVyQpwD4QW
         WlxMW5sUuHhK6KsRyUDPhPaFx77orUEwT9DOTT0tYaCDYKTqd8HeUKUv6pZR/dPnTBFb
         8iLIMiOpoGzAsnupiHvrza29NgQuNW5f/z1ykXW9zlyL10rGrXQESj8DS+Quew837uxh
         Rjqg==
X-Forwarded-Encrypted: i=1; AJvYcCUbBwQyFCHpCdSy1EbmuFtVMcm5NBCU1Em227n0jV+SPqyxukP12Bwvo+f7JuuWbujwPsbQk/zSCK1b7q7z@vger.kernel.org, AJvYcCUrukw9QvBC2/SGAk71U06txqMXOHa4H93CXW73B45rNMWg5YRa6eZNmgBU2NdheH7/E645cCNS3BvD@vger.kernel.org, AJvYcCX5c4+XN73D08+ts/S3YQlgNCLAqg0foSQQzZ60sEcVc87hjK1Ag3S/HTuLfynYF2gH8EvCg0k/YLPD@vger.kernel.org, AJvYcCXCmL/TB6fpom/JaXAdKcKTFTMzn8PKVSmH+CbdJcpwcphwppZRTuV2lxtvvrgsmDtqhwH7+p1aO9cuTQq3IFCnHdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSJQQWjT1XTmY19SE7HxQ5OUOGUiMKID7krnl1fKKn4VQbqCw
	rYQa5M1Sikw7dJ6QJKqttykORju2ue5Zw0me7FV+Y1euYfV0zQnx
X-Gm-Gg: ASbGncub61r2/3c6XJ4l2r/ablmJfZ992yKGTF1hOoR+4JdwAVe18Okico2rX8fVHFG
	IAC/Nr5JZDSYgScX2Gp4MYXLm3eQxJ5Gn4gZIw7GxHrMIRSYulh4zIXMbu3AHsrZSvNy1fKwZyk
	3Fk2zCEbSqonVc93Yhc48V014BJW4YEanJji4RilAhWGiVwUdTe/ujZHFGxxGbE7h8pB7iODjCQ
	oF5Lj9VxkJ0TW+LYJhEvTOxRgSLWTAF33y0vmEGJcul24QGJjJ3CF+LX2EuzvWXCbwo+gbJgcJC
	jyd8Ve8AeP1cf3DGQxcc7YcOu5KBnk2pw3vU0bZq/2J8peAm6WeJHWyKM3dfaBsrxofSG9VDkdO
	fng==
X-Google-Smtp-Source: AGHT+IEbOrNmVdw5FcMzDyc8UAFIIE9JT0oKWoJ4F5Nc8EupSUynLsydmXg7ZIfzN8EgM3Q2HbhJCw==
X-Received: by 2002:a05:6122:8292:b0:520:61ee:c7fc with SMTP id 71dfb90a1353d-52077df02cemr4492003e0c.4.1739479261624;
        Thu, 13 Feb 2025 12:41:01 -0800 (PST)
Received: from localhost.localdomain ([38.44.237.182])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5207aa40088sm285572e0c.10.2025.02.13.12.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:41:01 -0800 (PST)
From: Denzeel Oliva <wachiturroxd150@gmail.com>
To: andi.shyti@kernel.org,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Denzeel Oliva <wachiturroxd150@gmail.com>
Subject: [PATCH v2 0/2] spi: s3c64xx: add support exynos990-spi to new port config data
Date: Thu, 13 Feb 2025 20:40:42 +0000
Message-Id: <20250213204044.660-1-wachiturroxd150@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exynos990 uses the same version of USI SPI (v2.1) as the GS101.
Removed fifo_lvl_mask and rx_lvl_offset, and changed to the new data
configuration port.

The difference from other new port configuration data is that fifo_depth
is only specified in fifo-depth in DT.

Exynos 990 data for SPI:
- The depth of the FIFO is not the same size on all nodes.
  A depth of 64 bytes is used on most nodes,
  while a depth of 256 bytes is used on 3 specific nodes (SPI 8/9/10).
- The Exynos 990 only allows access to 32-bit registers.
  If access is attempted with a different size, an error interrupt
  is generated. Therefore, it is necessary to perform write accesses to
  registers in 32-bit blocks.

Changes in v2:
- Added a default "fifo_depth = 64" to prevent crashes when "fifo-depth"
  is missing in the device tree (avoids divide-by-zero issues).
- No other functional changes.

Denzeel Oliva (2):
  spi: dt-bindings: samsung: add samsung,exynos990-spi compatible
  spi: s3c64xx: add support exynos990-spi to new port config data

 .../devicetree/bindings/spi/samsung,spi.yaml    |  1 +
 drivers/spi/spi-s3c64xx.c                       | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

-- 
2.48.1


