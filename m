Return-Path: <linux-spi+bounces-5204-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003E699B2AC
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 11:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD761F21FF0
	for <lists+linux-spi@lfdr.de>; Sat, 12 Oct 2024 09:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682CA14EC73;
	Sat, 12 Oct 2024 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5v7wZ3P"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A8C14D6ED;
	Sat, 12 Oct 2024 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726865; cv=none; b=tyvlIpY1YqCLL3lEX8cqiTz9kkI1MZbG2q21pwg7Nn5aBi/HYDvXi7H3YPbvd3KDKp1x1hHd7GeLeGVcOmKVmD7Z1eR5+LNhOj6HR+JD07H455Xm2d5B5QfVdl6DyLiiRz4RwTdbuqSL4ut/IUTTld7CHe0FlFEarBsFT7SXi+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726865; c=relaxed/simple;
	bh=uzYCV3C5ywogwevDknJWbeHd1WeRLiOC8EiF7kVfrr8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GskbjjVjcKJng4oBlfKkt12z/ORGY67YblSc3B17TV8hFwUKz7bp4mJBaF3DCAhwYkpLqc9Jqvwl0T2MxJw2HJCIqkxp5xTYWexX3SOmHJ8KmPGN98oI5OXcqSS90w3nLZ7Gea/PABx0uClXC/fXrq9G5TnJ4XXt0I9q3pfpNlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5v7wZ3P; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a11e7so6874a12.3;
        Sat, 12 Oct 2024 02:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728726862; x=1729331662; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PXfgC7PAaimGHcxXjBS0/LEQlh9AIKoiQdb+I33fBJk=;
        b=I5v7wZ3PUyta0t75FcbuKKpI9CljUw7GiDopAAVNQvpD+kKT8nd2f5Y+63Tzf43Niq
         sLQOwpu/5lC+otW5clx7SoXkkaVcuioZW7XVm5N2NpPTkBe5uHG88qcok9ocyM/2CS+S
         +LV+K7MezXxLJxWPm8E4LGhu050qp6BhSaFgBBKI45pKIym3i/UFgffmhXzyRKEjnXHX
         aAs2yUjzNTMAazRkocV40kmCm4XvG7XTDVyYggtNN3sJpURqS8KnFcDTdks1h2NORv3R
         HkDZSW1BBbFmhqk6+Ma/j1inZoZ08dPmt6v/X0GET5YirNqpwGe8LXBysaOHq9R62AaF
         Jtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728726862; x=1729331662;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXfgC7PAaimGHcxXjBS0/LEQlh9AIKoiQdb+I33fBJk=;
        b=JvS9BccbWaj6alSmhHla9yX2PB9fNd7S7HceUyA1msNHaKpnIATPd4wwJPWljIvimn
         OgqCbZ5Qj9QRS8qVH3Zlu+tjmyMyOJ8GmWkmL+IL1ZIRK0wGnhZGBF4IJu0YIS0RiQ75
         +Wy1A3aDy6EdjyfUsvYwkBLCm2VNuoPoDQVHv3iiA4aGGARFAT5OX7uefub+ECSvB7Lb
         VVKvtt2mh8ALe9z1Thg2iuoqWLZt3yVqqUxQLONxSf8QO55+5kd4U9f+juyxJeFHSrwg
         6fXxHdkzaxgFk631WnZZUbbUCiOgK3E7tEqMq+Ide2oa2cJzk6/ceonPJV/fKIqSRjGg
         j6Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUb8Ez+4S6W0hepsqesZQYNlyEMOJkRGDnLep+UbTeeVeFXgJWLJJJDkrjcqF+hrUtU7LwmYyFuFDWltMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYuXDG8MTWa/CByGuoca/YecvubIUxvBztyUcH6t2Zf51Czw2+
	jgB3Ix7W7vfMpshQqt6v2aQ5OILLDvkvyMXXn8oLDaG2D+6Pkqdn+6YeluZ9uaE=
X-Google-Smtp-Source: AGHT+IGBRWq4YXFr7GZ5GEdU0E3NUKZWPdUREub7EMeNPZOo6L4mdIhBJvyx3i0OVF89wLJ6lO20wA==
X-Received: by 2002:a17:906:ef0a:b0:a99:6791:5449 with SMTP id a640c23a62f3a-a99e3e4c383mr226395366b.52.1728726861739;
        Sat, 12 Oct 2024 02:54:21 -0700 (PDT)
Received: from localhost (dslb-002-200-173-220.002.200.pools.vodafone-ip.de. [2.200.173.220])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dca54sm302092566b.159.2024.10.12.02.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 02:54:21 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
Subject: [PATCH 0/6] spi: multi CS cleanup and controller CS limit removal
Date: Sat, 12 Oct 2024 11:53:34 +0200
Message-Id: <20241012-spi_multi_cs_cleanup-v1-0-dc491113880d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB9HCmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0MD3eKCzPjc0pySzPjk4vjknNTEvNICXSOLJMNEQ1NDM0tjYyWg1oK
 i1LTMCrCx0bG1tQAFv+gTZgAAAA==
X-Change-ID: 20241010-spi_multi_cs_cleanup-28b1a1516933
To: Mark Brown <broonie@kernel.org>, 
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

This series aims at cleaning up the current multi CS parts and removing
the CS limit per controller that was introduced with the multi CS
support.

To do this, store the assigned chip selects per device in
spi_device::num_chipselects, which allows us to use that instead of
SPI_CS_CNT_MAX for most loops, as well as remove the initialization to
and the check for SPI_INVALID_CS.

This should hopefully make it obvious that SPI_CS_CNT_MAX only limits
accesses to arrays indexed by the number of chip selects of a device, not
the controller, and we can remove the check for
spi_controller::num_chipselects being less than SPI_CS_CNT_MAX in device
registration (which was the wrong place to do that anyway).

After having done that, we can reduce SPI_CS_CNT_MAX again to 4 without
breaking devices on higher CS lines.

Finally, rename SPI_CS_CNT_MAX to SPI_DEVICE_CNT_MAX to make it more
clear that this limit only applies to devices, not controllers.

There are still more issues left, but these can be addressed in future
submissions:

* The code allows multi-cs devices for any controller, as long as the
  device does not set parallel-memories.
* No current spi controller driver handles logical chip selects other
  than the first one, and always use it, regardless what cs_index_mask
  says.
* While most spi controllers should be able to handle devices that have
  multiple cs that just get enables selectively, but not at the same
  time, there is no way to tell that to the core (ties into the above).
* There is no parallel memories/multi cs flag for devices, so any
  implementing driver needs to check the device tree node, making it
  impossible to register these kind of devices via code.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
Jonas Gorski (6):
      spi: fix return code when spi device has too many chipselects
      spi: keep track of number of chipselects in spi_device
      spi: do not initialize device chipselects to SPI_INVALID_CS
      spi: don't check spi_controller::num_chipselect when parsing a dt device
      Revert "spi: Raise limit on number of chip selects"
      spi: rename SPI_CS_CNT_MAX => SPI_DEVICE_CS_CNT_MAX

 drivers/spi/spi-cadence-quadspi.c |  2 +-
 drivers/spi/spi.c                 | 71 +++++++++++++++------------------------
 include/linux/spi/spi.h           | 17 ++++++----
 3 files changed, 39 insertions(+), 51 deletions(-)
---
base-commit: c2a59c892f20379a3e48124a83491a12374cd7e0
change-id: 20241010-spi_multi_cs_cleanup-28b1a1516933

Best regards,
-- 
Jonas Gorski <jonas.gorski@gmail.com>


