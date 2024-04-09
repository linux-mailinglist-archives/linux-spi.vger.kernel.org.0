Return-Path: <linux-spi+bounces-2262-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EE889E2E7
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 21:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31C81C21197
	for <lists+linux-spi@lfdr.de>; Tue,  9 Apr 2024 19:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658DC156F47;
	Tue,  9 Apr 2024 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="Fv3ZcXwk"
X-Original-To: linux-spi@vger.kernel.org
Received: from sonic314-47.consmr.mail.gq1.yahoo.com (sonic314-47.consmr.mail.gq1.yahoo.com [98.137.69.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B137013E3E8
	for <linux-spi@vger.kernel.org>; Tue,  9 Apr 2024 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689498; cv=none; b=c6jYhfSu8NF7TLGM5JvbVf94ts9cadDMlSJk67HKqoesElBQns9df15u3/pcByWU+UWfcFwDc0zZKKJ0Ts7v72ndWvGAL9KAWHM6oFgO9fmdELsHyjQDQs6HK3sBbPLm7ttRwDrgnBmSQpmlNZEabesBjGBjX/c29mBjFx4hZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689498; c=relaxed/simple;
	bh=BQJfeRSufpFGodd8rMe466N1vCnYdEkSI0N66CuKxRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:References; b=nSHo+eBNUCtGnQ84cbmOAQiJRechZBxUG8rO+ziBa132RdNKLwlKrh7rGAE9OANZIElGnFvpc5lETeYpouPB/Bct6K/J6C0524Dl77qg5CSOKGxmdO4B678il6Ubcxcx74IHppWPK9X9QOrD0XfPS4sj1++OMfQ7CGScpzl4ILo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.co.uk; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=Fv3ZcXwk; arc=none smtp.client-ip=98.137.69.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1712689496; bh=lViEOK22o2scRmzhNDSZH/yExFY8hHG9CFsadvOzVnM=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=Fv3ZcXwk7Wo/zSgnEezDWhnIu41ZAELXZva4j31wwPbUsn04Vm0x4t9uCeX4FolXLts1QikYhsZ+WuLnCJv2ABz9ZWTytl1yaEDKg4YxAc79vw43i2VBuZGxjFLH2rsZPL8tW/FCc/ntKpApm9Oz2O9YMGii4F0Ec8JWDOt6C48OMV7oxzAc+Vavuo0KgyMAyzosV2oj2c7mXbJisqr+cHNHg7KTPPlSLPN4ErmMLDarA7x7MnlfxeNYgulhGMOA/JR3z8sao8aFlcag8NqE8mk4SpxfUsfddveESJJI4u8ZPCemqr8MGBOd7P+eGy5kjl+PYv6BBsLFgm3kgeu9sw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1712689496; bh=CnLbUJe24/W3lRtQGmpVREaNV3vOW3Rairozpg8gbIv=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=PNbMLyrTQQZ8nguhBt2kIVJ4DjvmmBs3s8CtW95mCJXGY3FW9gmPfAWNQfruUS2WkBbUOeAtSHBfon3xuc9cs6R7eXAPBkd0Ir8oHbBM4JtVngoXStskS9om7uxzjwdkn+a60nVci0os5UgZpaD4OSumyCGlXjL6UJ1mCQAziP9kDx4DOdW6w9ShwYr4sZLSHLyIgMdudVDs3s9p3I3bMK57DnyJY1fsS7Dr/oheSIKkQ38PtEZUJEoPvxvOA8jWYUm7HJtxc5KF2JeA84MWI65BDS0J1Cr/4Jh7xJ0X4MSx4OuJ46UtrdbrD5sFQtQkVErzUNQxyRTrUYEmvAOo3g==
X-YMail-OSG: pOh43NgVM1lN2IZlowie6.Cm_ISmlweqSYs0BNcpWUfZ2fjw__Y39lbzszerNE.
 Kx.tlM0wWieQPqcNuNGewxWfIkFdFNKAMQL4BftddnQeI6xQkcHDCe5CrVUl_f4OYh4H6XvUh6RH
 hKsxtzMgigIygMOFe.k2dTraP.GiGcmnkJ1qvyCw6icT8x9m4zw_z72fAEW_K07sLNBRz6ahqlM6
 LQL6V5NPZOP5_0n_Xhc7QUHFbEbIzRlnS8ybm7Y_c8mScptYlEL3llpvETW15eY_GVqCXGRloE_A
 _DXz9SLNZIFy_2Kcm7iWaDWda0x_bSzXfjD8hMGC0gRQUfDk72kr2tknP4JTtbS0tTjwgZBfF75t
 Q1xFBYf46iZ5kXUgAuYvJQ5aNjvYuduRPnESHkr_neqHZL.LMRz5whHnb8b47zDJw.sAE_HL1lYG
 80Q5pHMANZspvtt_oTkvFqomQAa6VEvUvZrxDKmZcD65vXJz88eJp89NLKAEqo0bB5fsr.NRpqme
 4f_7XRUoZLGtOcbXHgePVhlyTy7RPZlQWFEm7vf4BsOVIEC9ouW1SQ.OFXRYKqKx6JVaQZ1Jfnv7
 7Zgod78qeVGhxvaggBh5GQZOMrLerCDqgztzPElLjCySLLqZwUMb7Ho93Yb2AgAbRw1TZIA87dOB
 8CVc2MzwJl7KfIjaymK6Fmcd85RhcbJsy3Gzy1eqnVu2Za75GqOGw71fM25u0URgq_DnSIL3hSOT
 xmp34l8u9rHSzrVCErRLFFOWeBigThmjqjyPOzIbemA2lKSHfrQsQBr._mlbfpT6C8WZ6N0fz5qI
 uYcRVolcWNx4r8Gl6cM10X4lTSj1Fmre6fZh9pwqaL7VbL92y8GmA0JEM8KB5ga3yJRaY7vmZ_C1
 _w2KBhvD1LO2qILv9fFMNO2.KDf_YhA20Y3hX5TZ66GwsTqgqCRsrO67JWNqiCJeKf7GfDaDIwTE
 7QfT0i56DhQRfHakjmFqYDNIH3rEDNCFdcTJoQu3RgM3bzrEI8OEb9xhg94MJxuPaEwOD8A0hKxb
 xFIsggQ.7ekrdIdzEjhmgYZnBWZ7dFdTVN0XZL5ZxvH8z_1OreMOh8esj3Q0wb497OuyCDzwBU_b
 LWp6uuZee54nLN_I4TXbvvqy9vHZF1uayfO9Cwm0riCTRCTXfhbQCfDHYDm2dAteH3mD.brV4VBs
 zgOWZDusrfh8DlAoKLruM5Qoz3e_JibphZYfQmfvcyAP4xCEvzTUqPI.JwYA.W0hnSzV0gEWHahM
 VnJ673nsL.TlJkf7pyaIL57iAmDvt9FQPiKf_WRfPD8ULVyYTXGrqJSIqp95K8rHV17JOnwOMNpW
 9Ibsh7KyO0C.kgIy_dp8DXxnuG0OOVtv1tX5Y7Gof36jWbMEnhqTe34EGoQjRQDCzRAeGl2ZdM9a
 XSI4_w9HiEmGibApkOusBFNkQ2CE61WusM6iMiKKo2iQRT0ucHoJ8c2nH1ClQtrtijc8j9NNWsZ8
 73TTCSssetmNbmCWimrz6ZEhFUaOr_WNtw_Cf5aOa_8WudUXqdq6HKzVJZwgelgZwORgutMC7nD7
 lwN1YU5t4EjYrIycxmjTMzcQOcGM_9Kg9_K89lc72U7233xv6dZViZlcngOSfrR18TiqEHBs.r3V
 eQua6APP1rvwO_zcZx1I3hE00gF2sKcV5g1L63ijHykBE8XaX5gidzaSnJNeBM6ZozMsFsdir5.E
 vXtmqQh388qFn8VaDZAqx1_tubhyvk52gEyrGnHWCFfI6LiZ4MeHxMJ7yr8p4q4WdG39ruQe2cDo
 XS_m3LoDBpwPS7p00FOhPNYQBvi_p.pnJ5hQx2yYP.uqP9WLRIr3vcuaDOIyMGsA1CFMlRuccnus
 bpq29jyE4QFvGXMP4Ux6TY2_gX_2BfRuiWHOw2ICIELQC2mWcDrBa1nAgSV928.QnspxNY074x1L
 wPE6pNmpqmgHFXJy4LmWjJyrEZZf4BzNVpU5fX.rcKhdtKx8LJPqX_25dkmYF4AFbrk2R2OctA0c
 3vuzKGwiv2hERo0cTvB5KvVnHSE3UzRcLaxY5mrdVRlL5l3M5koVhGVdCamnX4705y5EaUid1KtM
 mkgqwWpFzdZM6VuOOLamIyPZG5J27KUGWo53Wp5qNhyhhpZ6GXHxXpm5JyW0Fh5Z9rXP6bUdNwlR
 wgmvA1BFtQnRFM5EefX9jQDf66FtUObnlmehOTaCxtQrMBLq.pWjMQ8IUHS6XMleP48yca89GlIA
 xIoOu5HVOpGq.fMXPXHFJtpqy8G8WjwwXqKZc4sZcHkzW
X-Sonic-MF: <rubenru09@aol.co.uk>
X-Sonic-ID: c39362b4-5d36-47e6-856f-466417afdca1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.gq1.yahoo.com with HTTP; Tue, 9 Apr 2024 19:04:56 +0000
Received: by hermes--production-bf1-7d6dbd57c9-78xqv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a5e4f95afd9edc1dd40f38e3c4f8417d;
          Tue, 09 Apr 2024 18:42:41 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Mark Brown <broonie@kernel.org>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] spi: Add documentation for last_cs_index_mask
Date: Tue,  9 Apr 2024 19:41:05 +0100
Message-Id: <20240409184106.22715-1-rubenru09@aol.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20240409184106.22715-1-rubenru09.ref@aol.com>

Documentation was missing for last_cs_index_mask, this was shown by
a warning in make htmldocs.

I have based the documentation off the docs for cs_index_mask, given
that they should be similar.

This is my first patch, so I hope I did everything right, please let
me know if I need to change something, and I shall endevour to do it
properly.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 include/linux/spi/spi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c459809efee4..ed941e65791a 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -453,6 +453,8 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @last_cs_mode_high: was (mode & SPI_CS_HIGH) true on the last call to set_cs.
  * @last_cs: the last chip_select that is recorded by set_cs, -1 on non chip
  *           selected
+ * @last_cs_index_mask: the last active chip select bit masks in the chip select
+ *                      array
  * @xfer_completion: used by core transfer_one_message()
  * @busy: message pump is busy
  * @running: message pump is running
-- 
2.40.1


