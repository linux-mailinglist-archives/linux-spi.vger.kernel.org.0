Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3923124D97C
	for <lists+linux-spi@lfdr.de>; Fri, 21 Aug 2020 18:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgHUQOJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 21 Aug 2020 12:14:09 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38719 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHUQOH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 21 Aug 2020 12:14:07 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200821161405euoutp02098c5975ef478707322683e8ef56f95f~tVJXz9ZKk0536405364euoutp02k
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2020 16:14:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200821161405euoutp02098c5975ef478707322683e8ef56f95f~tVJXz9ZKk0536405364euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1598026445;
        bh=z++olWEZiYHevwzEaZpqj3hyDJFzsFUj7ho3wt7OKh0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=JWvIOnj9QJUUBh+7Os3e+8vyFyDgDOgQ5wrUqMKQmqWL37yVt+WfbH2HOjymvejiD
         79VtEEauvI768CwzvAS91ys9wg8/tpZWow/rUnMOlcNWaHIASUV0LWlLtcXkx00+up
         uLPV2RD02FkgHnLFUHlm0FFGBwcpPASzacEJO40s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200821161405eucas1p2ccea9449b176120df3a3b2a5a01fc961~tVJXf_zf62032520325eucas1p2g;
        Fri, 21 Aug 2020 16:14:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BE.9E.05997.DC2FF3F5; Fri, 21
        Aug 2020 17:14:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200821161404eucas1p20577160d1bff2e8f5cae7403e93716ab~tVJXDyjyL2032520325eucas1p2f;
        Fri, 21 Aug 2020 16:14:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200821161404eusmtrp1fb99f20d180cd5fa6291e4be553fe7f0~tVJXDDJ-61179011790eusmtrp12;
        Fri, 21 Aug 2020 16:14:04 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-c0-5f3ff2cd2ab2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2D.A9.06017.CC2FF3F5; Fri, 21
        Aug 2020 17:14:04 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20200821161404eusmtip26563b85b475ad000c6271d91c80bc5d1~tVJW03UKt2050020500eusmtip2R;
        Fri, 21 Aug 2020 16:14:04 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2 0/9] Some fixes for spi-s3c64xx
Date:   Fri, 21 Aug 2020 18:13:52 +0200
Message-Id: <20200821161401.11307-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djPc7pnP9nHG0zYI2mx+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFvcPLSC0WLT42usFpd3zWGzmHF+H5NF48eb7BZrj9xld+D2uL7k
        E7PHplWdbB6bl9R79G1ZxejxeZNcAGsUl01Kak5mWWqRvl0CV8bF4zeYC25wV7zpOMbSwHiK
        s4uRk0NCwERi05WLzF2MXBxCAisYJfbuboVyvjBK7P/UxArhfGaU+D9nCjNMy6epXSwQieWM
        Et97F0K1PGeUWP9rCSNIFZuAo0T/0hNg7SICE5gkHp57wwaSYBYolejZeQjMFhYwkjh0dRE7
        iM0ioCpx7sZKpi5GDg5eAWuJ849tILbJS7Qv3w5WzisgKHFy5hMWEJtfQEtiTdN1FoiR8hLN
        W2eDHSEhsItd4lfDKTaIZheJhgP9ULawxKvjW9ghbBmJ05N7WEB2SQjUS0yeZAbR28MosW3O
        DxaIGmuJO+d+sYHUMAtoSqzfpQ8RdpR4P28CM0Qrn8SNt4IQJ/BJTNo2HSrMK9HRJgRRrSKx
        rn8P1EApid5XKxghbA+JPasms01gVJyF5LFZSJ6ZhbB3ASPzKkbx1NLi3PTUYqO81HK94sTc
        4tK8dL3k/NxNjMCEdPrf8S87GHf9STrEKMDBqMTD++OQfbwQa2JZcWXuIUYJDmYlEV6ns6fj
        hHhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBaBJNl4uCUamAM4v9yYt6P
        tMRjR4QucYZkRVzcPe2aDrfMx4CzYX/rHju5N2W7JOmlfFypvf/r3L0L376f+2ztLM7vCb9P
        HtpRvdfzq/jyDW77D7VbODiU7VohkND80L35ZnLJvRilvRuOn/xQpBuRe4hf25Wztvwy599N
        LMe8pqcWMDbVOvavjeFVYDi0LDtdiaU4I9FQi7moOBEAJvyhfUQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xe7pnPtnHG0zdaWqx+MdzJouNM9az
        Wkx9+ITNov/xa2aL8+c3sFvcPLSC0WLT42usFpd3zWGzmHF+H5NF48eb7BZrj9xld+D2uL7k
        E7PHplWdbB6bl9R79G1ZxejxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5
        rJWRqZK+nU1Kak5mWWqRvl2CXsbF4zeYC25wV7zpOMbSwHiKs4uRk0NCwETi09Quli5GLg4h
        gaWMEqvPPmbqYuQASkhJrJybDlEjLPHnWhcbiC0k8JRR4vQKUxCbTcBRon/pCVaQXhGBGUwS
        T25MZgVJMAuUS1ya9ZwdxBYWMJI4dHURmM0ioCpx7sZKsPm8AtYS5x/bQMyXl2hfvh1sPq+A
        oMTJmU9YQEqYBdQl1s8TAgnzC2hJrGm6zgIxXV6ieets5gmMArOQdMxC6JiFpGoBI/MqRpHU
        0uLc9NxiI73ixNzi0rx0veT83E2MwFjaduznlh2MXe+CDzEKcDAq8fD+OGQfL8SaWFZcmXuI
        UYKDWUmE1+ns6Tgh3pTEyqrUovz4otKc1OJDjKZA30xklhJNzgfGeV5JvKGpobmFpaG5sbmx
        mYWSOG+HwMEYIYH0xJLU7NTUgtQimD4mDk6pBsby7746ByaIRjIGnjvDvbr93vfdretnsb9j
        UVzuY3vztdi0htfLQ7N+sb7ddHuVtWyEXKWMzfkXMbq3fj0R5zEqXuCpevWByIUKQ2n5U0on
        NLqi4wvm8qezRkW8N95+WG1l6aueGR3NBZ+eqrVVi7EqvY9c2xNZ3xTy9nhfy4T0O37/FKof
        aSqxFGckGmoxFxUnAgDVFelNuwIAAA==
X-CMS-MailID: 20200821161404eucas1p20577160d1bff2e8f5cae7403e93716ab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200821161404eucas1p20577160d1bff2e8f5cae7403e93716ab
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200821161404eucas1p20577160d1bff2e8f5cae7403e93716ab
References: <CGME20200821161404eucas1p20577160d1bff2e8f5cae7403e93716ab@eucas1p2.samsung.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is a series of fixes created during porting a device driver (these
patches will be released soon too) for an SPI device to the current kernel.

The two most important are 

  spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and s3c64xx_enable_datapath()
  spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for Exynos3250

Without them DMA transfers larger than 512 bytes from the SPI controller
would fail.

Łukasz Stelmach (9):
  spi: spi-s3c64xx: swap s3c64xx_spi_set_cs() and
    s3c64xx_enable_datapath()
  spi: spi-s3s64xx: Add S3C64XX_SPI_QUIRK_CS_AUTO for Exynos3250
  spi: spi-s3c64xx: Report more information when errors occur
  spi: spi-s3c64xx: Rename S3C64XX_SPI_SLAVE_* to S3C64XX_SPI_CS_*
  spi: spi-s3c64xx: Fix doc comment for struct s3c64xx_spi_driver_data
  spi: spi-s3c64xx: Check return values
  spi: spi-s3c64xx: Ensure cur_speed holds actual clock value
  spi: spi-s3c64xx: Increase transfer timeout
  spi: spi-s3c64xx: Turn on interrupts upon resume

 drivers/spi/spi-s3c64xx.c | 111 +++++++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 32 deletions(-)

Changes in v2:
  - added missing commit descriptions
  - added spi: spi-s3c64xx: Ensure cur_speed holds actual clock value
  - implemented error propagation in
      spi: spi-s3c64xx: Check return values
  - rebased onto v5.9-rc1 which contains
      spi: spi-s3c64xx: Add missing entries for structs 's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'
-- 
2.26.2

