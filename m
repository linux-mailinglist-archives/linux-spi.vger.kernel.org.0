Return-Path: <linux-spi+bounces-11398-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A41C744BD
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 14:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0EE34F4ED1
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 13:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FBA331232;
	Thu, 20 Nov 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VcHJJ1/K"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEF0328B48
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763645052; cv=none; b=TpVmq9Tj9/EeoCPewg5G3eQ9POxqiv4/64R8AhLOTksHyFHfpISCv/G9B5YVu50Q4aoNDsk1nSeMtrseqtR8XM185jrj3Ct4Rnt9fq/uwVELD27FWLeuVSm/p3G4tyqgmWu+Q7rhIEGa4yKRqLLLZe+4Z6dv2zndwfuI+sXbgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763645052; c=relaxed/simple;
	bh=51XNPM/yaY4YnFAne9KwnVRimXv4WSkxM5Xh5pA88fw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uoEZoVuW+swY9ODTpsKkquFhxQtgz2SfYeZLPCRGBGwI1WmqeCEI4PEakgjYtR7CBFRiCavqKVvpBvMHXocnIPNtBKKYfdthGusxeEChrBG+xPV6vPRqhBOvhJt5b60QS7qJ6mWOuKmakFJ4Oen5qDdREXRijRgtJI/72Aj8eYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VcHJJ1/K; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so9910125e9.3
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 05:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763645047; x=1764249847; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4ox0Av9333Bk5KhUuA/HknOZMJhB8eUpeZCV5zbk4D4=;
        b=VcHJJ1/KdeAvIigiwOWkF+95dHK0IcorWb0r1K61hooIaRG7tJ8uACEyuZz4AvRH2b
         v3x9evS0BV4nfr9/xtrNCfVy/BLnayDdlsHyqTKKDO0uD1KLLgPTI0eAI8ylEz6mnljo
         z1LtOlNvUASzxut/o3xp0Jgz84lJQsaAHVVypa5Y3BqE1IbrQVAUna6kmccwArfGoL+3
         aGlF7O3zEgltnpvEfBXWoZyxR+uYK1JpjHwU4/u0MZi1s2oB2Pmcq+JNPiUZ6ViEm5hD
         25qmhg2IUlT+ICp1C4BhPWtjwMW1k4e0ApPszG9/AM/cmcF5GgnnyKibE28JPpFHZKfh
         df7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763645047; x=1764249847;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ox0Av9333Bk5KhUuA/HknOZMJhB8eUpeZCV5zbk4D4=;
        b=mXBVM7tE3Npt8EoECr+hyYk0h9XdU07llp34jM5smFrDNFKDgYqRwOVU/8/scpE2ui
         +JhoXmtTcdJiSwZOPOI0bLdD1LIHwuhtzIS5DbwsTkVQw/JXIKnojIrVyjT9ZoQG5yga
         tLq470EFjQ217W/LxrbISoWDaWQB6Rp075FjDWw6E7InLc6xoq5yuD97ra70qj7kPxI6
         oi3GecrX9KC9umubSy5S2CQz8NOP32p1g5rk4gPBMJXXqEmZcnq9ne1/8AOtx5OJ03vP
         mhzb61A16jguue1Vjp0JyuvM/FZAAveS7/FSbG4/XivJOZyPx2VyqduR04phr0Hr08A4
         BP1A==
X-Forwarded-Encrypted: i=1; AJvYcCX/tp85XvYLB6zGfLD0va8DYvIpjPC7HxqE9cb/J8GA9rwo/cgztg9AvoOeAwlvUkyQarBdwZcbq5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4rurEstp2i+Ou6rgHJHkPcZEXQfkzMirXEyVHj2SrIzfArlfj
	ty2RKUx4KKyU/oHSN1BCoQtJi6xRp00OFuWN3CjizbLD3Xo72Q1lQZMHC7LieZcKBPpW9B/5Q2H
	l9cQNE/42ng==
X-Gm-Gg: ASbGncsvavIIBLJr2pnDjgX/JBJte7ioyJ7LRIlPTO8e1tkzYKrTxkqfBIL7M7mm0bz
	pmsdmJRmpTb5JvvPrFPqRhXEkfqT0XwKJh7BJW3b4BZ5bDbIZLBaBYc3cbBCv8KLigbfupCTaO/
	feOwS3hShNsrnlVIkiqKaHi2so8C9RfKfg53GZpS2rwAw53XF6+5QrhQMNx0rjcjTj6lK4vfK5o
	kA9l4hY5opVDbUdXvhRDRh8Ywys1M/b+GFCVpNlufUBoI4p1vbH1/KIH3eN4DP3FDUovvfzDwS5
	Xa5JyY2INLuVL8EspLChR794059YrHRqCUs4N7PLG/mQfVE9u7wwMwzHKNzeQW5wmFJAzK8A0uC
	QXTtU6rc/+yUmR3yKjFOQeaNNApnPgM/0Xrk0X02wAAU1dawRiQyQd9DezFmy+sDG7/BV6DQeEv
	0ylpE=
X-Google-Smtp-Source: AGHT+IEzrmOuk1754BTh0RKyhuWggn7zYc7485t/Pt53ATrGsSvLq3wQE/Y1Mi5Rnkse+8xOSKWkJw==
X-Received: by 2002:a05:600c:358f:b0:477:9650:3175 with SMTP id 5b1f17b1804b1-477b835c667mr43592605e9.0.1763645047188;
        Thu, 20 Nov 2025 05:24:07 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:37af:6c1f:28a:47d2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82cc72dsm46762935e9.1.2025.11.20.05.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 05:24:06 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v7 0/9] reset: rework reset-gpios handling
Date: Thu, 20 Nov 2025 14:23:55 +0100
Message-Id: <20251120-reset-gpios-swnodes-v7-0-a100493a0f4b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGsWH2kC/3XQTWrDMBAF4KsErasyGmn001XvUbqQYtkRFCtIw
 U0Ivntlb+pid/kG5pvhPVmNJcXK3k5PVuKUaspjC+blxM4XPw6Rp65lhoAEDomXWOOND9eUK6/
 fY+5i5V0gklEbcBRY27yW2Kf7qn58tnxJ9ZbLYz0yiWW6egJAH3qT4MB1JyVScL5X+P6VRl/ya
 y4DW8AJNwjiMYIL4sBakoBOhB0it4g7RuSCSOvVObR3QOwQ9YsIkMeIWhClhQUI2hjaIbRFjju
 eqCGi10Y55y1as0P0FvmnWL124r0l7KKL6g8yz/MPh/2wmxACAAA=
X-Change-ID: 20250925-reset-gpios-swnodes-db553e67095b
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Mark Brown <broonie@kernel.org>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-sound@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-spi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 stable+noautosel@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6012;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=51XNPM/yaY4YnFAne9KwnVRimXv4WSkxM5Xh5pA88fw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpHxZudwW8q0/QBGuB2XUg7KRvkVPVW4milgtqL
 vsek1SD3aGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaR8WbgAKCRAFnS7L/zaE
 w1pWEACNUAEHcAMYwRGuqDLKPqmWR8hJIxAvRudZgyrxWq8xV1MZWjtTj3zifbCMPi9EwaGlK12
 7q7bU/NoLy9BR8JpRbI8seFj7Fu7cLbrFpBQD8CjV7vhluIIjqC+9fOO1Oa+xgPQulJ420kQ+Bn
 w6SXxRELuF/mGXkO6g1n/4NHvk5fTs7CIsfh5wQwa0Dv/MRDn1i9spom87IxurQCYGwf6V04fdf
 swWxUCGbKRFpCk1pDy5+YOsk7S52vX6tlfC/ARAMkZ2aB2DPe5AE2PN8kRABzgkIy+ff9PtXNhC
 AYAI5uIIiK0f4sCIQ25G7dIK2KIzyOXhkAp6S6aTj4EAlovJwl+MhbTYohyMgiFatp+5iBX7vfr
 S/bBzevBzzKTYInpMzNj64YbxXBusp2bEPArtkifln6bYFIMgPaIEQvoe0Gj/vHrFH62B/KYD3N
 pVxrjACXhT8469gg09QDQQ/7gsk9VL7OY3yf+d2ZxlPb9bNUSBANNSbZc2qehHsAk1K0FcHHY2N
 cSp1iygPGNdEzRLMTU6srwvr783uaIKNoyC0kfr5pwsLEz6mLGFQxdae3kbkz3dHfgfeNaMEZDD
 rllCNk3GDUwACQBK+i34CLEUu8OZnetWBODbT3WGGxPYgPTAenRUGH5q/dq5G/1zCDifg4392m9
 UqoyNoNrd33Dg/g==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Machine GPIO lookup is a nice, if a bit clunky, mechanism when we have
absolutely no idea what the GPIO provider is or when it will be created.
However in the case of reset-gpios, we not only know if the chip is
there - we also already hold a reference to its firmware node.

In this case using fwnode lookup makes more sense. However, since the
reset provider is created dynamically, it doesn't have a corresponding
firmware node (in this case: an OF-node). That leaves us with software
nodes which currently cannot reference other implementations of the
fwnode API, only other struct software_node objects. This is a needless
limitation as it's imaginable that a dynamic auxiliary device (with a
software node attached) would want to reference a real device with an OF
node.

This series does three things: extends the software node implementation,
allowing its properties to reference not only static software nodes but
also existing firmware nodes, updates the GPIO property interface to use
the reworked swnode macros and finally makes the reset-gpio code the
first user by converting the GPIO lookup from machine to swnode.

Another user of the software node changes in the future could become the
shared GPIO modules that's in the works in parallel[1].

Merging strategy: the series is logically split into four parts: driver
core, SPI, GPIO and reset respectively. However there are build-time
dependencies between all three parts so I suggest the reset tree as the
right one to take it upstream with an immutable branch provided to
driver core, SPI and GPIO.

[1] https://lore.kernel.org/all/20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org/

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v7:
- Add a SPI patch from Charles Keepax that uses the swnode changes to
  improve the GPIO lookup in cs42l43, this is required before we switch
  to the fwnode-based lookup in gpiolib-swnode
- Revert to the previous way of checking the return value of
  fwnode_create_software_node()
- Link to v6: https://lore.kernel.org/r/20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org

Changes in v6:
- Do ref[0].swnode -> ref->swnode in software_node_graph_get_remote_endpoint()
- Fix some nit picks from Andy
- Link to v5: https://lore.kernel.org/r/20251105-reset-gpios-swnodes-v5-0-1f67499a8287@linaro.org

Changes in v5:
- Use _Generic() even more and simplify the patch allowing to reference
  firmware nodes significantly
- Use _Generic() to avoid adding more macros to linux/property.h
- Don't rename macro arguments in linux/property.h
- Drop patch renaming the GPIO reference property
- Pick up the patch modifying the swnode GPIO lookup to using fwnodes
  into my fixes branch
- Simplify the patch allowing GPIO swnode references to reference
  firmware nodes
- Link to v4: https://lore.kernel.org/r/20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org

Changes in v4:
- Fix an issue with uninitialized ret variable in reset core
- Use _Generic() to simplify the __SOFTWARE_NODE_REF() macro and remove
  one of the arguments
- Add a comment explaining the relationship between swnodes and fwnodes
  and why we're using the fwnode API in swnode code
- Allow longer lines
- Link to v3: https://lore.kernel.org/r/20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org

Changes in v3:
- Really fix the typo in commit message in patch 7/9
- Update the commit message in patch 3/9 after implementation changes
- Don't remove checking the refnode for NULL and returning -ENOENT
- Move lockdep assertion higher up in the reset code
- Simplify patch 4/9: don't change the logic of inspecting the gpio
  device's software node
- Add new patch that still allows GPIO lookup from software nodes to
  find chips associated with any firmware nodes
- Drop the comma in reset-gpio auxiliary ID
- Drop the no longer used type argument from software node reference
  macros
- Link to v2: https://lore.kernel.org/r/20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org

Changes in v2:
- Don't use a union for different pointer types in the software node
  reference struct
- Use fwnode_property_read_u32() instead of
  fwnode_property_read_u32_array() as we're only reading a single
  integer
- Rename reset_aux_device_release() to reset_gpio_aux_device_release()
- Initialize the device properties instead of memsetting them
- Fix typo in commit message
- As discussed on the list: I didn't change patch 7/9 because most of
  it goes away anyway in patch 9/9 and the cleanup issues will be fixed
  in the upcoming fwnode conversion
- Link to v1: https://lore.kernel.org/r/20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org

---
Bartosz Golaszewski (8):
      software node: read the reference args via the fwnode API
      software node: increase the reference of the swnode by its fwnode
      software node: allow referencing firmware nodes
      gpio: swnode: allow referencing GPIO chips by firmware nodes
      reset: order includes alphabetically in reset/core.c
      reset: make the provider of reset-gpios the parent of the reset device
      reset: gpio: convert the driver to using the auxiliary bus
      reset: gpio: use software nodes to setup the GPIO lookup

Charles Keepax (1):
      spi: cs42l43: Use actual ACPI firmware node for chip selects

 drivers/base/swnode.c         |  30 +++++++--
 drivers/gpio/gpiolib-swnode.c |   3 +-
 drivers/reset/Kconfig         |   1 +
 drivers/reset/core.c          | 146 ++++++++++++++++++++++++------------------
 drivers/reset/reset-gpio.c    |  19 +++---
 drivers/spi/spi-cs42l43.c     |  40 +++---------
 include/linux/property.h      |  13 +++-
 7 files changed, 141 insertions(+), 111 deletions(-)
---
base-commit: 8892aac2160438329ea14463cb272c3f9be98214
change-id: 20250925-reset-gpios-swnodes-db553e67095b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


