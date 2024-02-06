Return-Path: <linux-spi+bounces-1109-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8B884BEB7
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 21:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 624C51C23AF0
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 20:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E89B1B80F;
	Tue,  6 Feb 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K0UR7+ei"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ACB1B7F6
	for <linux-spi@vger.kernel.org>; Tue,  6 Feb 2024 20:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707251608; cv=none; b=NiQnux9nUkuhHgJQNvESvl/LXM2PtnEN4IM9BWNh3rVv5+QYIRxKM2jLZD0M8vt+SRW8MnUWrqyLrvdIjfGrYS8Ov/4BOis779CqWNs3D7QX0fASQ9bENRl0eBBXRVqPnP8YatRqV9WJhs6nOBR1EazAiLntjD03W1Wxiiv32rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707251608; c=relaxed/simple;
	bh=MPYoHxeKPCnc9gpbdDoN3NGU8IjyGGLHn+vuIM5QKh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rAd3nu7uccijYKrqiTOFR3pHD+CeNoDiqVAGjEqvqkLBvYLRT6n5BGjRxNqPE5TeylqsBWoqttVudYJhG3VhB3REvCnYSaBCPdOoM9Tysar2cVYZsfrW4uIuLSAXGYLMFAk8/A7iTGgZmgpfkXBeppUyz3edOvQam/kcmDe6iSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K0UR7+ei; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e117eec348so752196a34.2
        for <linux-spi@vger.kernel.org>; Tue, 06 Feb 2024 12:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707251604; x=1707856404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ubZDa4GWwL/GMCOFFCbm4p521hfLHa5fIJTQTEH+mC4=;
        b=K0UR7+eiRyU6G3jpRDUeWqAu7iC/OISFVgQBtg7w2V5NI4mzdkIw3y0MBNU3an8chS
         ki36mByrOjRfjDvrGWFaWGgueP2sx3eo0JkibrmTDKSfPYkf6oAOWLSv7yEAuvcx86fM
         r41SCGdSF4bQd5Gnu7jWXp0EGODdjAcnZ7v5g940zhUSdwFRPQUqs6P1FTmNAqzR35oR
         a9WL1phrDOH5Sjcgdm9PWEbrawM7KMlIkhy/vkjSd060SLZ5v/BJCPmHRHTNYWYHcxBM
         bizAp8pZ/RowrZ4XdJ4TCAO6F6T/Ryk+Gkby3iARdUm+n7bAQk1qGvH9UoyMmsqUwHO3
         aEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707251604; x=1707856404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubZDa4GWwL/GMCOFFCbm4p521hfLHa5fIJTQTEH+mC4=;
        b=nxIvOOTnDeIT6I555O7e8wahSjHl29vPdw27O6H8tnSdaHiRzu1AUYxxepJdtJQavg
         /4GJ9WgyObndgHc1Xid3+udxyaN3NkNp4/b21V/GVFR2uxEmBDBgwGFTtBtfu51XL34K
         W5MEMSYoVxHayGBsGLdcHh6KIoKQrucp1yoNUA20+bC87FUDLcYZqdUG0in1vaNYJYT1
         rmENZq++CDDeTovtBwFKdKdpxxd1o7NJLAkVOB5NW2C9PvicNhjkmWAatl5t4hfHAE2q
         QvN7lQiemfgtlbxl4FtDQBIfvyLhbOlA3aiSSgF4pKSrZFzCllNILnOxzvqsHCh5aRMy
         FeHQ==
X-Gm-Message-State: AOJu0YwQcAMYDVqpF0sMboZEL3+AiS7EK4EEHnLVG+mHz9gI/aCC450f
	qskU0EIAIdIb8t+HhCKaI2Zk9QiT5M8C5GuXC14PkcdBl7tiQ4l81UNGHVTmsRHVh+8hnA054oz
	z
X-Google-Smtp-Source: AGHT+IF0MmuI1nUFe/V6BG088Po9XJTU/8bWeJ/mJ+JIYIErtoYQg1qL7uENnk68DxBaPoLm840gHA==
X-Received: by 2002:a05:6830:2b07:b0:6dd:e52e:1f53 with SMTP id l7-20020a0568302b0700b006dde52e1f53mr4437162otv.11.1707251604638;
        Tue, 06 Feb 2024 12:33:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUc4QlC/D04/jFnLNY7nLmAqLbKweCSCNCkkSvJLolyaHb2T9nN3NySWtiFf98CM5bizcVXIkRpJ5ju+e4aKC/BUwjYjtiS+hFiXyY+Ssi2QCiXvux8G46o3V9eXGaqeCPosPvinboR3YCxzR22EfPPRimG/cP0Rg11U4+C9opdgaIkukQ6yFYV1MeTNyz6PyRJ8w==
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id l2-20020a05683016c200b006e11d93ff09sm429581otr.72.2024.02.06.12.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 12:33:24 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: linux-spi@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] spi: axi-spi-engine: performance improvements
Date: Tue,  6 Feb 2024 14:31:26 -0600
Message-ID: <20240206-axi-spi-engine-round-2-1-v1-0-ea6eeb60f4fb@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

While researching potential performance improvements in the core SPI
code, we found a few low-hanging opportunities for improvements in the
AXI SPI Engine driver.

---
David Lechner (2):
      spi: axi-spi-engine: remove use of ida for sync id
      spi: axi-spi-engine: move msg finalization out of irq handler

 drivers/spi/spi-axi-spi-engine.c | 67 +++++++++++++---------------------------
 1 file changed, 21 insertions(+), 46 deletions(-)
---
base-commit: 80fa6a033ac8c395a3de4840e204638e92b8b371
change-id: 20240206-axi-spi-engine-round-2-1-bb73990abac3

