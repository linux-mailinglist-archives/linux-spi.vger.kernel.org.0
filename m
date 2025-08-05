Return-Path: <linux-spi+bounces-9282-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B346FB1AC42
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 03:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600DD3BB997
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 01:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C56B81720;
	Tue,  5 Aug 2025 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifHSu8ld"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B490F288DB
	for <linux-spi@vger.kernel.org>; Tue,  5 Aug 2025 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754358854; cv=none; b=tX5ZCf1tyxaiuzqWFqcZIXlHajYXIZaokrDTZXIwYTL3QIE/kwnK1r4FK8f47/SC4c2wyehR/+wfeAjE+yXmMDU1n+PkJu1YFUcZx+Vvg8xBqAEFNvo4kfWdmaxWTkrCIFzZIqMzULdaxNfT5FIWcp128FsopcARHZer/nQIY5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754358854; c=relaxed/simple;
	bh=O6UnOhXJUKAsJ35zUie5JSRVM5UqY+cfYhFM07TLRIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DHzpPJUoTjWRlCxRIDtB93Cs9lXyOe9xjKwem2qw2SmNVVE0N548T4mNC4VPKhb/Zt3/7fTxox756SC+LyJmrt3I69Jj0XRiC2slmmlCFEtVvCw8SvkG69tWxqWtU2pN0oe08+tQAN/risAvKWsfy2DpoHvdW79lDqyKMk3R5aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifHSu8ld; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-31efc10bb03so3638791a91.0
        for <linux-spi@vger.kernel.org>; Mon, 04 Aug 2025 18:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754358851; x=1754963651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/AvTT+NJ5DNR9j59CjbspQIejXkVrxU43H4i3i/mS9g=;
        b=ifHSu8ldA2w2toyJz3+/50+Za5oMuczaFZxwu4i6hQueJreGMSHoZT15Dba4l/sugt
         k+91rC5CA7Vyn0tAzm86te2QahopJjRMliMwW09SkuoGpeTF/yYrUxDHBt7maaGOpB32
         dpuV+qVe+sKzfMccDvNMF8OGpo5vSqmaW0zn7SyGG4L7gZKMizVNA6nG3sLS+Htesm+u
         oBw238Q1+UW/YM3KiEO7jnvvYPNUOUrZxbKLjPNtcYXQs8VVOIBvY/JT0QVjGt/vjcAX
         CuECLx/6ubcLou8I5b13IoLUMBQOMjy9gdZR5dNimy3lXFx0Sl1RtitSradFr294XgLM
         dAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754358851; x=1754963651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/AvTT+NJ5DNR9j59CjbspQIejXkVrxU43H4i3i/mS9g=;
        b=VW1QaKPO8uDYI5T/L4+dr7/9tGuVG1gcCMiTRe1VfQCwi6vNSCa3fz9FisOVWLU/fv
         jOnAEmrEtK+1Vfk14CfJPaDfiJNHCi0nnXdXiXm8vq2pWWkXy3g6GTjuUiBc/TmMEZcP
         A5bJwqAGRT7eFUn0qXxkQHs5aP0KerU1t5Asgl5LG5S+fuz73cdBWWpe4ytVElaq/VKm
         KW8wYZRz5PF9PMPGBNdBr4jZm1id8Dxyjmp1Vr27QShVCSofpw6PidHdFokfxGsj4Y52
         j0zgEgKxzYRY7V2FE2zvtC8gc5fZsadFBaSpES7DcvwB6vHbpfhEWB1qI2vV26Kl+w2p
         NL8g==
X-Gm-Message-State: AOJu0Yx7ey2ov1MH6Lx2hQSwIko6+qce3xdEQv8BVqskuajRCQ3OycsI
	oq8e7TEFw/vxgXWTcXo/sxVtphcs7b/qCd1xquJB0pyQ4W6QyZrpx2jO
X-Gm-Gg: ASbGncsgrYtlI2oyCgvScvlQIoThBLhPSg9jAQaKObF5k0mtRei2wikX3GFWha//5d4
	Y/gLc5mNv6HEbaWA0luvfuPUWzO+BMmmoUeWfDVOKYnv8ECo6djy8tAGhiqnq70sYqhpsAR/+d9
	hJz//WBu+CahQylgW0zXhD5/X3nWwxhjn55cSHRdNmiRl2DjORUmbhjdbC2ZQjoOBjwbJC/GJA6
	68jUbMWeT/AL7WJywRDVYnEtCC6O4VooPHihI5yknew/bJz5j9w/SqwP9INtMpjmIA4dHp+lMWv
	7LmlGuCGXiJH+lDm+sk+3rHO1pjmoHttko3jW4Ha7SwvELZpTlWlnS+bVbR0rowSSWeNMfY50vK
	4OLAANHVYtMyjSkoLxhsTSabTBC/LNHrOAeNaREJMd3qyMF9h0oGKMD3rEG2i2mr44aY=
X-Google-Smtp-Source: AGHT+IFbdxSODQqAYcXthYi41GV6TKkEAXLUXcJdXTnhHo7pqv/bEYhvdEzIzGPU3wYjZUUSkGK+7w==
X-Received: by 2002:a17:90b:1350:b0:31e:c653:38ff with SMTP id 98e67ed59e1d1-321162b79b2mr13915647a91.27.1754358850783;
        Mon, 04 Aug 2025 18:54:10 -0700 (PDT)
Received: from TIANYXU-M-J00K.cisco.com ([2001:420:588c:1300:55e3:2a99:432c:259e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63ee49c7sm15365725a91.21.2025.08.04.18.54.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Aug 2025 18:54:10 -0700 (PDT)
From: Tianyu Xu <xtydtc@gmail.com>
X-Google-Original-From: Tianyu Xu <tianyxu@cisco.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	miquel.raynal@bootlin.com,
	Tianyu Xu <tianyxu@cisco.com>
Subject: [PATCH] spi: spi-mem: add spi_mem_adjust_op_freq() in spi_mem_supports_op()
Date: Tue,  5 Aug 2025 09:54:03 +0800
Message-Id: <20250805015403.43928-1-tianyxu@cisco.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function spi_mem_adjust_op_freq() within spi_mem_exec_op() adjusts
the op->max_freq, which will informs the SPI controller of the maximum
frequency for each operation. This adjustment is based on combined
information from the SPI device and the board's wiring conditions.
Similarly, spi_mem_supports_op() will check the capabilities of the SPI
controller. It also requires the combined information before it can
accurately determine whether the SPI controller supports a given operation.

Signed-off-by: Tianyu Xu <tianyxu@cisco.com>
---
 drivers/spi/spi-mem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 5db0639d3..753dbade8 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -265,6 +265,9 @@ static bool spi_mem_internal_supports_op(struct spi_mem *mem,
  */
 bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
+	/* Make sure the operation frequency is correct before going futher */
+	spi_mem_adjust_op_freq(mem, (struct spi_mem_op *)op);
+
 	if (spi_mem_check_op(op))
 		return false;
 
-- 
2.39.5 (Apple Git-154)


