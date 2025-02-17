Return-Path: <linux-spi+bounces-6841-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39AFA37E6D
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2025 10:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC96616DE3A
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2025 09:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFA82135A3;
	Mon, 17 Feb 2025 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGHgz7ON"
X-Original-To: linux-spi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FE21323E
	for <linux-spi@vger.kernel.org>; Mon, 17 Feb 2025 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784543; cv=none; b=UIofh3xVa07hJe4i1moZut2Uz/M4tnPoIRd3sg6pTT9M0ecxL/gBoR6jo+KXhZPQRsGZNMrs7wX3Pqx/ZspRMKaUA5GZUv++Of8B6O3ximHEnRlN1FADdTQ78T1i/CFETIIgufYXa1RP4w5j7iB2PBEgeWDrqNIl3MNz9FYweEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784543; c=relaxed/simple;
	bh=DvnzqR3N+Yt1hJiN/UFuDlnF+d8ai01tb91e7tKjUK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=ERBxXxCteYXYFSK2YV2ahd5W1I1xJbp4Y2X1qCR3VChvj8I9cVSXWLf1FRHC1/OImXqbBGxqT9iMyB4q5UKEBhzM8bAxonZ9lr0zGrOYcw4MCYAan4ir1iFjC53q/hxGrsfwxlifm4QfzLrpOnty1FeIFG6WdEP7kd23+BX1voE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DGHgz7ON; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739784541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qeVUNDEioZ1zA8ELxm1OFFvu01528gdmuR0pSmN5LWs=;
	b=DGHgz7ONHrBHFCruUsyPfpkLrU77qlbFt6L5+dZHjvWQSkxRV+T8B3BRistPEi9YhSi0x7
	4BKP3VCEWcMpnbYdLwIKPUFxAFeLwhRR+yr4bgkwIkwBZ6xlzJhaz1/EV8CdQMQlG1uVor
	lKwVmrAu9hSjmpjrrQ/YozxKo8gUv6E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-7RQjQ-ScOhyYTc2Fil982Q-1; Mon, 17 Feb 2025 04:28:59 -0500
X-MC-Unique: 7RQjQ-ScOhyYTc2Fil982Q-1
X-Mimecast-MFC-AGG-ID: 7RQjQ-ScOhyYTc2Fil982Q_1739784538
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f2ef5f0dbso1231958f8f.2
        for <linux-spi@vger.kernel.org>; Mon, 17 Feb 2025 01:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739784538; x=1740389338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeVUNDEioZ1zA8ELxm1OFFvu01528gdmuR0pSmN5LWs=;
        b=kz0GvjlJpt1JH3kAyJe25WtBjVi4SagJRUh2OCHl8T8eaRPmeN+o32GHUOtvDnzy2Z
         cUTLFlannEs98R/d7ziZHl025fWOmno/AzY/tnKhKlQcm/l9EpXbttMv/9DEiz+H0WK/
         q4TfgsUy36m/+3QPQYHlKePUxDZudO651j6R0eQ0n4duEdM5ih11WVpwiGtOT1k8LrMJ
         wLcOQxk3WL++T7TKIJbK5zM9vdhJEYq4F0fkelPyqrFMA/gjHV3RSh0ZmAAYedJGfAOj
         2EpjDHx8UGMhCAwHkrAacGP1PHpvCXBlP89X2AmDjd7Wsyx5bcrmgoxIbieU4SHu6mlX
         Va9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwNX99Fc1LN1iowYyT3xlCrqaRYGZLZqMz6iK1xjDzuMV2MmKG4G+EwQaaK+a0Vz2h4cUuvZw+Yyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNklzrrpE0oEhLx1pO07gnroFgF8WvpXsV3ivSJIV5v8DriuIq
	Msty59XZ6eUh9O2/qtEzeYiRNNnU5Ve9uNFFO4iitEbKla44qEZKqBFDeZOwMDqzjdL0nYEJ2sb
	nTnC+gMZSuQsVP9ZwK+3hX8tDc5RfsAERyCr3UY7HEbX3xfwmrZDid8dwgg==
X-Gm-Gg: ASbGncvyy+p59vpSVX2lYu/3Hqi3Y1qnH0zoGUzGq1+eD9O/x6mk4XZODQxc4M0Quvs
	6cYa2DJ/vpNkQiQijGrgVAkWyX4xXz3sRNQ6C9HSRKrLS1kaknlIU0LxlMwEWOnvfx9wUO5Iqil
	/syrYbS2BsuhUpKRLb66ueupxwr6qoBZUvtZFMDdrNzmWMbldmfu5/lZjlFlVZ/X6X18i5nY5tU
	oAYl+vncDzSJ/Gj2eQIoCfPhOcGQ5UJFuLKdIubTajdQaBhiZY4GfjG7tL9Wbqgql2mHZqkPXUE
	MGSOo+v0ZegI25c0h6yp9TbdqTcWz63tl7t8I0b3fS+ORUCSpQGI
X-Received: by 2002:adf:fa08:0:b0:38d:df70:23e7 with SMTP id ffacd0b85a97d-38f33f34cecmr6714671f8f.31.1739784537698;
        Mon, 17 Feb 2025 01:28:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrmijOoGMXonbnwZyd9fLGlM4O8FZOdIeSBCVRiU0u4DCtv0gGZP/fVwdyLL1x9WLMBEhxAg==
X-Received: by 2002:adf:fa08:0:b0:38d:df70:23e7 with SMTP id ffacd0b85a97d-38f33f34cecmr6714640f8f.31.1739784537284;
        Mon, 17 Feb 2025 01:28:57 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7998sm11554234f8f.82.2025.02.17.01.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 01:28:56 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust the file entry in SPI OFFLOAD
Date: Mon, 17 Feb 2025 10:28:51 +0100
Message-ID: <20250217092851.17619-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1d9J3cvjmvEOUkxeFq3bwIRq93lfRV5DnzEUZvRB_ec_1739784538
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit 8e02d1886988 ("spi: add basic support for SPI offloading") adds a
new MAINTAINERS section referring to the non-existent file
include/linux/spi/spi-offload.h rather than referring to the files added
with this commit in the directory include/linux/spi/offload/.

Adjust the file reference to the intended directory.

Fixes: 8e02d1886988 ("spi: add basic support for SPI offloading")

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a54d8510ea6e..53cf3cbf33c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22402,7 +22402,7 @@ SPI OFFLOAD
 R:	David Lechner <dlechner@baylibre.com>
 F:	drivers/spi/spi-offload-trigger-pwm.c
 F:	drivers/spi/spi-offload.c
-F:	include/linux/spi/spi-offload.h
+F:	include/linux/spi/offload/
 K:	spi_offload
 
 SPI SUBSYSTEM
-- 
2.48.1


