Return-Path: <linux-spi+bounces-11123-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01202C41A61
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 21:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9158D42126D
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106A030EF9A;
	Fri,  7 Nov 2025 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yprmy1Z9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922C018C2C
	for <linux-spi@vger.kernel.org>; Fri,  7 Nov 2025 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548826; cv=none; b=PexGRhreH3M9N5Oho8dXaO8+grz0qTDS19sqoaaCdq2iQgXM3ujyOJCyawzvtadkBpxpo06ykLTuJgrYFv4H3FIJy/pTVzwPRViFGKdJYcgLnswk2hQFH7ap1yi/OKlORug7Q7N3KOwq95dDWIprVqiWWRTXmkOwZJLrnNB5ER0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548826; c=relaxed/simple;
	bh=EpVgqo2v/0JBXNziS+eCmvU2qI9GWnrR9mDBLBMOyJ8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jvyXhHGNpJZLHCImNFFM3hFPxD70qM+UyFuixKR60AcXpfsOT41UUjgU/4JV1bJf/GrWACRJ51fLNq3Dp4xf/b0Znlybe6wZYP66OJS6HnS2r2f8i4xVecrCF6XzEc1nC7sZcRHfaii+9eET6iGlJkg/E9c+z+T4YkStbibPNGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yprmy1Z9; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-656b1f906e4so510905eaf.0
        for <linux-spi@vger.kernel.org>; Fri, 07 Nov 2025 12:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762548823; x=1763153623; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gOuYDt+s1jtJNdWwVbx2gWl2Jr6Jhg5Tz5DiyqP1X0=;
        b=yprmy1Z966rIFlM+qGbh1I1KSht4ihc8O2DXeNR4cSzL91SRsC2o7mtlXOoOaaW/Eh
         DniRONBYs/zajJYb+rmqmQxAcdyhS2W709r+Yj88OFyy/SsGuZnaJBThs/U6ec6HNTAM
         3FUj8S4Mye/+lj1KkwNK0EaT+UIATa0m+cKaHKTtmGVD9ElDz46fsyzW0VSSwpdrhlIt
         Hw/aDnU61PX4Dbt1NBtC5Ug5DU1kvRzosDKRhtce5FTbLgr+EvyQXLRdXL22zq+rdHlB
         eOqUOVlBNzw+oqc++PQt/WqwPKyxgBi0Bq+TAIyx8QVPMy/EfTlhadmdv4q3ffTtBVcb
         H+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548823; x=1763153623;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gOuYDt+s1jtJNdWwVbx2gWl2Jr6Jhg5Tz5DiyqP1X0=;
        b=g4ZvYGTrp2nos95uhOtEaiD4oicYUMfHs1yi5RQ1zUOsBGXiEUk0vk7Z4kje7J73/0
         Do7wzKNY/IAsSiRj9J4eVG9VNl7ocQErjlyC/8dm6Poou4wtvejywhoX/20cgHwsp/i/
         GX5fO2mVPeDlxefH6fFVbSUuCDSzkVZ7Nrl7NZaw3pnBHKKOoOzcctjXQeGuQnouX/XL
         bV1HPs5Rx/4ah0J0uXNYc+72yRaeoDuyp0USh7KiRR/G8/Hau7tklIEnoN2MNxwp5lhW
         MpaBNp6OOxsdGv7kvKyyGTQhC8UXj+0xGVE42AJY1c96ynZYidk1lH+DgA4bK2eo2E3Z
         z3KA==
X-Forwarded-Encrypted: i=1; AJvYcCVXJAqn5qplbFmlV6zR+gCNwJJwh7q4lt3OrBeXS6ZMPPSDq31f1dZROa3D3OKWkrGN+0+ExpDl5PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm/CtW09R9vLkcIAsIFUwJXjldd/niqVmhQNEghWCbnDiHU+GQ
	slPOkNMeadxANH92AGP4vOiHLdRAr1IaP8RsdB65CfSb/xH8ao0Q+mPQ2iFPbiRXGLE=
X-Gm-Gg: ASbGncvVZRc53sRgyLCYbBPApB3PbzPKtmhrv7NoN/sWxiCWlF6G1c3kh4YSf3GMK7n
	aMSTgQd1SRMYenOoy69jkR/s6XJGlcDZyiUgDGfWCVd6PgD4VtjLYdxVk0NTLmO1aNKQc4sbBs5
	Y+V2uJpgybwfsqdYo6j4ltzFDtD44lUU2D5FASMl8qxjjGZzjgolIjLinYNcKgX7wKE1CwjoisI
	T7LOsmNbi0uIK4Xt+ybzIs+KHVg5T92yImE5EriFDaKbLuCOHxOKEPrUO0FZTJnKelCNEQ2ZpO4
	XoJShmgBc5739/losY8W7ThggrZmSMi/kmymAPna9OeHqZnEvgNHsVByzn7cPP1FeU0UE3T4q4T
	bYiHZ1ou9SD2GEzFcMfHHdY+dh1VTmUqeFOLytOruk7pteufNCe1QHYhQ2jHvyS+xAqI+Qa+1Qg
	zAgD53
X-Google-Smtp-Source: AGHT+IFXl+nfu0q8+xI0hJxiOW52RV8VlfHFe9go24ubMqqAb1xpi3RHHUr4UHdBzwIkl2Fv+CCopQ==
X-Received: by 2002:a05:6808:2210:b0:44f:8f02:c75a with SMTP id 5614622812f47-4502a321198mr396341b6e.1.1762548822596;
        Fri, 07 Nov 2025 12:53:42 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57eae5esm2915601eaf.16.2025.11.07.12.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:53:40 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/6] spi: add multi-bus support
Date: Fri, 07 Nov 2025 14:52:46 -0600
Message-Id: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB5cDmkC/32OSw6DMAxEr4K8rquEEtqy6j0qFoSYYolfk4BAi
 Ls3wL7LsfXmzQqOLJODLFrB0sSO+y6E+BJBWRfdh5BNyBCLWImHVOgGxsIYbMfGM+rRoRuHobc
 epb4pI1SpkiqFwA+WKp6P7nd+ZkvfMSj8eQRdOMKyb1v2WdTR7HHXSCnusAM1O9/b5dg2yYM4/
 kImf2ZMEkXoeT5KGZu0UtVLF0vD2tI1qCDftu0H02BJT/YAAAA=
X-Change-ID: 20250815-spi-add-multi-bus-support-1b35d05c54f6
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3831; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=EpVgqo2v/0JBXNziS+eCmvU2qI9GWnrR9mDBLBMOyJ8=;
 b=kA0DAAoBwswgAf8Bj8AByyZiAGkOXCWjOokw1YvHZeERiY9tQ7lCxYJJapSJOmws90Rt0RNVW
 okBMwQAAQoAHRYhBOwY2Z5iDoPWnNhomMLMIAH/AY/ABQJpDlwlAAoJEMLMIAH/AY/ATXMIAJed
 rE8vL5+a+BrfFb//ZywMaqJHgbc6yfLEwR1QYIVbcFdkuVUwckiftr83YA9YPVs3adFkT6+jYju
 dVzMj6AlOFSdRSJMSSKY+ZzXd4wvMSEgvjx+eFeqCte1u4SmVjIrL+jqOEFfx/8gJetez2VZFsd
 oqdHK8lp4Yskptr+uv5hkSileILVb83Uv/vpPBBt/wbZlUKWSLM5CMhkDbWQfoBhygNwuyHXduo
 VNl6l2l2UotMuJO9yLvCNXVzb0eB6X5bKLNzsVbPsv2zES3zBf+5vP9fUwsFpiDU0Gd1FxQSE+5
 TqHw4FlobsZW1kY1LECU4OrvsFKgHpZ19w6fK2k=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

This series is adding support for SPI controllers and peripherals that
have multiple SPI data buses (data buses being independent sets of
SDI/SDO lines, each with their own serializer/deserializer).

This series covers this specific use case:

+--------------+    +---------+
| SPI          |    | SPI     |
| Controller   |    | ADC     |
|              |    |         |
|          CS0 |--->| CS      |
|         SCLK |--->| SCLK    |
|          SDO |--->| SDI     |
|         SDI0 |<---| SDOA    |
|         SDI1 |<---| SDOB    |
|         SDI2 |<---| SDOC    |
|         SDI3 |<---| SDOD    |
+--------------+     +--------+

The ADC is a simultaneous sampling ADC that can convert 4 samples at the
same time. It has 4 data output lines (SDOA-D) that each contain the
data of one of the 4 channels. So it requires a SPI controller with 4
separate deserializers in order to receive all of the information at the
same time.

This should also work for the use case in [1] as well. (Some of the
patches in this series were already submitted there). In that case the
SPI controller is used kind of like it is two separate SPI controllers,
each with its own chip select, clock, and data lines.

[1]: https://lore.kernel.org/linux-spi/20250616220054.3968946-1-sean.anderson@linux.dev/

The DT bindings are a fairly straight-forward mapping of which pins on
the peripheral are connected to which pins on the controller. The SPI
core code parses this and makes the information available to drivers.
When a peripheral driver sees that multiple data buses are wired up, it
can chose to use them when sending messages.

The SPI message API is a bit higher-level than just specifying the
number of data lines for a SPI transfer though. I did some research on
other SPI controllers that have this feature. They tend to be the kind
meant for connecting to two flash memory chips at the same time but can
be used more generically as well. They generally have the option to
either use one bus at a time (Sean's use case), or can mirror the same
data on multiple buses (no users of this yet) or can perform striping
of a single data FIFO/DMA stream to/from the two buses (our use case).

For now, the API assumes that if you want to do mirror/striping, then
you want to use all available data buses. Otherwise, it just uses the
first data bus for "normal" SPI transfers.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Renamed devicetree property spi-buses to spi-data-buses. (Driver code
  was already using spi->data_buses, so it matches).
- Fixed a small bug in the AXI ADC driver changes.
- Moved one line of code in the ADC driver changes.
- Link to v1: https://lore.kernel.org/r/20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com

---
David Lechner (6):
      spi: dt-bindings: Add spi-data-buses property
      spi: Support multi-bus controllers
      spi: add multi_bus_mode field to struct spi_transfer
      spi: axi-spi-engine: support SPI_MULTI_BUS_MODE_STRIPE
      dt-bindings: iio: adc: adi,ad7380: add spi-buses property
      iio: adc: ad7380: Add support for multiple SPI buses

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  22 ++++
 .../bindings/spi/spi-peripheral-props.yaml         |  12 ++
 drivers/iio/adc/ad7380.c                           |  42 ++++---
 drivers/spi/spi-axi-spi-engine.c                   | 128 ++++++++++++++++++++-
 drivers/spi/spi.c                                  |  28 ++++-
 include/linux/spi/spi.h                            |  23 ++++
 6 files changed, 237 insertions(+), 18 deletions(-)
---
base-commit: 1a26618e7466b8d825989201086c235e76aa999a
change-id: 20250815-spi-add-multi-bus-support-1b35d05c54f6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


