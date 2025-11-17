Return-Path: <linux-spi+bounces-11251-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F248C6398C
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 11:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB933B4437
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 10:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1303328B51;
	Mon, 17 Nov 2025 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RraCXQbO"
X-Original-To: linux-spi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3243E326956
	for <linux-spi@vger.kernel.org>; Mon, 17 Nov 2025 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763376052; cv=none; b=O5QbsVzocLo5HCuS3QOFgthGTA6zktEDb+XJngJEmKn9+hvPcTCo9bWeDbck4kWqQ6L2mIOBpQaUKDdvvN5Nq5KUJaKrsK2cAIvB+QwNNLqc+6rDdEYFZXJ5lbkV0mCKEUORK4zrUPO2Xvs/zuFA9CRCzIPQ4W4wrfry4X5KvHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763376052; c=relaxed/simple;
	bh=AMWmt45bE/sNq//FAFn52LtOJH5BEcAVLHelh7huOBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=exZP43v6FVSSR9onw0FI8bNn/gC+S/+Gi8o+HzE4x3M6RJqtPY8JHWXoj4Y9cWenLsQ6r3cI3cgrfq70S2oNkRXK4hBhyLcBz9fD06Nw1QFrbyY33ewgY1nTH+adyTUCCNF+v1L4FH1mPNXX2MqlACwDdd5dSJHrT3sGwqU2jPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RraCXQbO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763376050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kAUfjZ6BVnYL57JWajx/Z1xJhvt0maWRmCYifK1Tonc=;
	b=RraCXQbO23QfgOHaZMetKIIj9VUqiqC7z9Q05gq5ldw2cTE+qjPTznI8KL/XLjHiWMrBR1
	iqPCtRM8VR/4L67mMj25ftKeSRoKdUZVElMiryfWV1dCuiWuWVUwfnti8Xpp1L7gh3aahJ
	iCln3YHlrZhr3nXeCkw8M80ahDTL/GA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-1sMV6fIDOFCihC6CjjYfJA-1; Mon, 17 Nov 2025 05:40:49 -0500
X-MC-Unique: 1sMV6fIDOFCihC6CjjYfJA-1
X-Mimecast-MFC-AGG-ID: 1sMV6fIDOFCihC6CjjYfJA_1763376048
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2fb13b79so1947723f8f.3
        for <linux-spi@vger.kernel.org>; Mon, 17 Nov 2025 02:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763376048; x=1763980848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAUfjZ6BVnYL57JWajx/Z1xJhvt0maWRmCYifK1Tonc=;
        b=tgnJ1Rx/k3xYXsaYoOP6pGWOEDWGLSF2U0BMNUncEgWRFAlY92wtAaPSoQbUYkahIh
         LyO+SPU7ytpRymAZqI7Sny0HR9/7+qEXcs0amWXuLelknJYw1e6K0LUKV/MI/5V4T1ew
         3EgeeShD5EB71EBWIx8ne0ib19n5UD8voc7D6o+6OnKauzkwTKgxkkWvQIZpExeJ+pEr
         8WwmgykhRp01Jfm5b2D/9ORw9yuwYju6Dj/AM24lb0+gKiApY55qISVKK2/Sz8OAztSV
         apxIymsiArg4uDoYK/tlg7fDDHDmB1RS+XlZHVT5dv7uIyvNdQi455B0V+urhPKynyBI
         I3eg==
X-Forwarded-Encrypted: i=1; AJvYcCVRiGBo2xIynDmBEpk18Y4p/WTE72SAzgSyvrUAWV1brMXtVb7iJBwOCU3V0mzshpURGbRru2IEIQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV1EwhFZYfbXHG1KfmKneU9+zq7IqBLHFUkL4XixffDCypEmow
	m7XEvwwYoeluTA+X+bJs8XgLGUas+hnDItLPkGYP/rySdZFzBhi7pVi08WCF5NKYFI3Fzjv8aoH
	QyO6ks/PzjRivbnwPTuzSuYcgHsxhn/I0RS9+tMkq/jlReBHiGJKCS2CRHoNsEQ==
X-Gm-Gg: ASbGnctWovgCSTl7VcrxGPiTAVqyWUyzRII0d6OBAyEZYPtBjEltEIySJvpmn1gS/QW
	iu8TED6EWFgu2CN0/26v3BS/J9IXu5+W53O413Rqlcy+NlqGgj4M4dafzb0Oz8azudF/RiBYpxI
	H/W8/FsH0NiPEz/pBC6kmwF1QWzJ88E0cBXQAK5SAezy0MnCUZukbgJH+J29uTPNTOYuubx4ajG
	QoXnaQpVsJJQ3jb4xLzuK+iC7ZyP4fLTwQgwxl0DFxhHl/ki3vQ4IVPbALxrt+XcoJQ6He9Xy/2
	7aXRqQNFHnrhYgkIBIX2Bao3hrlCb9R1RL5R/03JoMuiTSm2cwTTlbr3s9vXyDsMnHAtxpWFPFZ
	kLTikLAiTlbPzDk8b8T1uGxte6MgZQ9fFTbgQWN41LKR0f8I9
X-Received: by 2002:a05:600c:1f92:b0:46e:32d4:46a1 with SMTP id 5b1f17b1804b1-4778fe96324mr111237965e9.22.1763376047733;
        Mon, 17 Nov 2025 02:40:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDlPS2oFFSJ+IKiQOcZ0dVKJrAeryW0seKkZC07kxLfKJ//4N95dOnEcejlq4qUG/ZdKbm3g==
X-Received: by 2002:a05:600c:1f92:b0:46e:32d4:46a1 with SMTP id 5b1f17b1804b1-4778fe96324mr111237665e9.22.1763376047320;
        Mon, 17 Nov 2025 02:40:47 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477991646b2sm130447715e9.7.2025.11.17.02.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 02:40:46 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in RISC-V MICROCHIP SUPPORT
Date: Mon, 17 Nov 2025 11:40:44 +0100
Message-ID: <20251117104044.291517-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bCnRxxl19brKyM73gdoMWNAx-9bPqvUnr61CNrfA0Yk_1763376048
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 71c814e98696 ("spi: microchip: rename driver file and internal
identifiers") renames spi-microchip-core.c to spi-mpfs.c, but misses to
adjust the file entry in RISC-V MICROCHIP SUPPORT.

Adjust the file entry after this renaming.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ec635515c0c4..320045a6bad9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22372,7 +22372,7 @@ F:	drivers/soc/microchip/mpfs-control-scb.c
 F:	drivers/soc/microchip/mpfs-mss-top-sysreg.c
 F:	drivers/soc/microchip/mpfs-sys-controller.c
 F:	drivers/spi/spi-microchip-core-qspi.c
-F:	drivers/spi/spi-microchip-core.c
+F:	drivers/spi/spi-mpfs.c
 F:	drivers/usb/musb/mpfs.c
 F:	include/soc/microchip/mpfs.h
 
-- 
2.51.1


