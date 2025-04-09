Return-Path: <linux-spi+bounces-7490-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A4EA82C41
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 18:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7F387A7F65
	for <lists+linux-spi@lfdr.de>; Wed,  9 Apr 2025 16:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5556D26B2A7;
	Wed,  9 Apr 2025 16:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDYpNhI/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700AD26B0AB
	for <linux-spi@vger.kernel.org>; Wed,  9 Apr 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744215859; cv=none; b=bUseC0/Jg4xkB1oFZlM3mnRwcItNsJne8lfwEh4dUlI3Lmj7OgpYyP+FD8nFmcW58C+Lb6mKrSDw0BadIR8JepUV8mBS3bDiRcg5IyAasXfwGDZ7cFdxL1RH1DMezLveJ7DsM0Qvw8CEzrR+04G9qp0ogzRD62jjbsS8isndFwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744215859; c=relaxed/simple;
	bh=fw7WbWS8cKjd25UbiI89dhTcptikmUi0FwaU+YmCcDk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=o9yDbY40L2KSoUTqsBlhSMRmidFk1rYNChpd9hrgHr+d5wMDrW57bnhqQETqj1Rz3TWGL9bkJtccg12IVCZ74o94Q2T2ASVOOuq+KyxAVGnldua8hITskrnbqrcH8Lv5fHjc/918pVT3JCjNIArBXVZh7m5Wb9teQ9VwJvlDc9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDYpNhI/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so36100815e9.0
        for <linux-spi@vger.kernel.org>; Wed, 09 Apr 2025 09:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744215856; x=1744820656; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYj/35g5FFOOquxcyCYaaISOQCe0r8ISwMRrs2+FMD8=;
        b=kDYpNhI/EGpkQBHPOjoGDFRuEazqZo26ngcRFY9H9qLNFK/7CMk6IXgTRx2vgCs2d5
         zixLYRvRkAmv9HIZ4V2R8AMmlXsvEAJcByBa794ySn8QvvI2UqJtRVlbGaaB6pmc4q4m
         HaAL8zt62gi+ve/tdt5GT/AO2NxV3vuYimjN3AherkjsaMW/e3UPnyUnjwMV6DwE0V/o
         wn3ChqlC8qPI1PDvRMFwCt6hOdgW7KFG8NGNnPLBNAHYzZFx5NA/Oq4T7nwn5cdH7d0w
         Jn3YumJlYMadYB8e5qnqyAONOLvzSHhXzQY8feeCRVrRAdwbAvfILnh6GGJreHSeG0GZ
         Pt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744215856; x=1744820656;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYj/35g5FFOOquxcyCYaaISOQCe0r8ISwMRrs2+FMD8=;
        b=CSVLQtGfmm06oSFQMe2fvt83CEuQ74YdC+WKycyB9oY4Hh7glb+hxlIZProIQiOpND
         zen7XZFptmBt4fbk3RUAITsJvucQscOcWDfFL7P5FrAo8vHN0YUm7otWYzO7q0RcrhhY
         pEdYoXd3iBdpj4MkaS5s7ZBrjqPRmtIZEoy/u/RDgwvLQkRXua5nVrFP+rMNPwmcqjRL
         6AfmJKul1q1YmzpVBH2OKLXHxghlMweQKemihocTXEiivNChXG+UZizqbOAkTEyu4X5Q
         eibZaIq2oTxzE22zMx88TagrUbpOm03cAPgTvUewQ41duKXlO50lGN+hF41MzmgwL3k7
         3kyg==
X-Gm-Message-State: AOJu0Yx8RJ4cCpmB2q50Gw/9YZ4Eqrr1mQWmkpdzAKuIKbXnOXUlcpSX
	pJwA6Fpw6aUFdhUPSFdWc5rC0KwXf7C2dkql70zbnJcVWAssO9LA/t0rGw==
X-Gm-Gg: ASbGncsEAygczr9y/WLtD8811f1oFWpuD+i2eDWHtlCHYiRSyulruSO1MsibJK7osnp
	g+Tr4NiEce7P6eNliUALL27iAUhBWxU15pmaQGr2A8Vgirrj8G7vka8fWMQkTgynB/v+eNO/PsE
	KcBeCSHsydYD1PYbFxfihJOawbUcH7r6fhSIPtNYwEmrN406bRkzrigAkpR6w5znHD4lWDfo82a
	uRDe7+iFm+NFB7+Ou73ioSKT1Y8Zlqnk3PoGafMHt35nysdaF18oaFmrWz57dWy6VyJWBkA+4zJ
	LGJGGatmCJMRkXVMOyQZhen/voqDm0KmVdwgC3CGBZ6udjmNLE6pZzD/f9SRMQNpvBd1uyRrulV
	7uI0yYVefSt/Bb6mYM+UvuqZllwK2RIyZTIB36V/O+mX97ycz2n8FyGFxY+knzCauwJa/+hR3/u
	qNRWz9DWf6QXyGiNl9HCRaAFSy1hgoAZwA
X-Google-Smtp-Source: AGHT+IEA/FltPaFCSUrX+Hvu+cU+f92WlnRhz1uBUjL2TH5F5sOGeSlzsx2LQKFgiZoCgGcClxESfQ==
X-Received: by 2002:a05:600c:3b85:b0:43c:eeee:b706 with SMTP id 5b1f17b1804b1-43f1ff399d6mr26469835e9.24.1744215855282;
        Wed, 09 Apr 2025 09:24:15 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9c75:6000:2d50:87f4:9992:caad? (dynamic-2a02-3100-9c75-6000-2d50-87f4-9992-caad.310.pool.telefonica.de. [2a02:3100:9c75:6000:2d50:87f4:9992:caad])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39d893f0b35sm2042024f8f.70.2025.04.09.09.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 09:24:14 -0700 (PDT)
Message-ID: <2585fa05-60c4-48c4-a838-e87014665ae2@gmail.com>
Date: Wed, 9 Apr 2025 18:25:01 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] spi: intel: Improve resource mapping
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Let's use the pci/platform-specialized functions for mapping a resource,
and pass the mapped address to intel_spi_probe. Benefits are:

- No separate call needed for getting the resource, and no access to
  struct pci_dev internals (pdev->resource[]).

- More user-friendly output in /proc/iomem. In my case:

  before
  80704000-80704fff : 0000:00:1f.5
    80704000-80704fff : 0000:00:1f.5 0000:00:1f.5

  after
  80704000-80704fff : 0000:00:1f.5
    80704000-80704fff : spi_intel_pci

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/spi/spi-intel-pci.c      | 8 +++++++-
 drivers/spi/spi-intel-platform.c | 9 ++++++---
 drivers/spi/spi-intel.c          | 9 +++------
 drivers/spi/spi-intel.h          | 4 +---
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-intel-pci.c b/drivers/spi/spi-intel-pci.c
index 4d9ffec90..4b63cb98d 100644
--- a/drivers/spi/spi-intel-pci.c
+++ b/drivers/spi/spi-intel-pci.c
@@ -44,6 +44,7 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
 	struct intel_spi_boardinfo *info;
+	void __iomem *base;
 	int ret;
 
 	ret = pcim_enable_device(pdev);
@@ -56,7 +57,12 @@ static int intel_spi_pci_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	info->data = pdev;
-	return intel_spi_probe(&pdev->dev, &pdev->resource[0], info);
+
+	base = pcim_iomap_region(pdev, 0, KBUILD_MODNAME);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	return intel_spi_probe(&pdev->dev, base, info);
 }
 
 static const struct pci_device_id intel_spi_pci_ids[] = {
diff --git a/drivers/spi/spi-intel-platform.c b/drivers/spi/spi-intel-platform.c
index 0974cca83..6cbed0b2e 100644
--- a/drivers/spi/spi-intel-platform.c
+++ b/drivers/spi/spi-intel-platform.c
@@ -14,14 +14,17 @@
 static int intel_spi_platform_probe(struct platform_device *pdev)
 {
 	struct intel_spi_boardinfo *info;
-	struct resource *mem;
+	void __iomem *base;
 
 	info = dev_get_platdata(&pdev->dev);
 	if (!info)
 		return -EINVAL;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	return intel_spi_probe(&pdev->dev, mem, info);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	return intel_spi_probe(&pdev->dev, base, info);
 }
 
 static struct platform_driver intel_spi_platform_driver = {
diff --git a/drivers/spi/spi-intel.c b/drivers/spi/spi-intel.c
index b0dcdb6fb..5d5a546c6 100644
--- a/drivers/spi/spi-intel.c
+++ b/drivers/spi/spi-intel.c
@@ -1467,13 +1467,13 @@ EXPORT_SYMBOL_GPL(intel_spi_groups);
 /**
  * intel_spi_probe() - Probe the Intel SPI flash controller
  * @dev: Pointer to the parent device
- * @mem: MMIO resource
+ * @base: iomapped MMIO resource
  * @info: Platform specific information
  *
  * Probes Intel SPI flash controller and creates the flash chip device.
  * Returns %0 on success and negative errno in case of failure.
  */
-int intel_spi_probe(struct device *dev, struct resource *mem,
+int intel_spi_probe(struct device *dev, void __iomem *base,
 		    const struct intel_spi_boardinfo *info)
 {
 	struct spi_controller *host;
@@ -1488,10 +1488,7 @@ int intel_spi_probe(struct device *dev, struct resource *mem,
 
 	ispi = spi_controller_get_devdata(host);
 
-	ispi->base = devm_ioremap_resource(dev, mem);
-	if (IS_ERR(ispi->base))
-		return PTR_ERR(ispi->base);
-
+	ispi->base = base;
 	ispi->dev = dev;
 	ispi->host = host;
 	ispi->info = info;
diff --git a/drivers/spi/spi-intel.h b/drivers/spi/spi-intel.h
index c5f35060d..53b292c6e 100644
--- a/drivers/spi/spi-intel.h
+++ b/drivers/spi/spi-intel.h
@@ -11,11 +11,9 @@
 
 #include <linux/platform_data/x86/spi-intel.h>
 
-struct resource;
-
 extern const struct attribute_group *intel_spi_groups[];
 
-int intel_spi_probe(struct device *dev, struct resource *mem,
+int intel_spi_probe(struct device *dev, void __iomem *base,
 		    const struct intel_spi_boardinfo *info);
 
 #endif /* SPI_INTEL_H */
-- 
2.49.0


