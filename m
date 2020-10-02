Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBE7281268
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbgJBMX3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 08:23:29 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54067 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387875AbgJBMWz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 08:22:55 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201002122251euoutp02b95669a4bee266b237803831ad7ecfd6~6LFeKx0OB2196421964euoutp02C
        for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2020 12:22:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201002122251euoutp02b95669a4bee266b237803831ad7ecfd6~6LFeKx0OB2196421964euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601641372;
        bh=p2pv26AUz3sdJjPIGSfGwPfSHH+cfHEZoyM3/33Kj9w=;
        h=From:To:Cc:Subject:Date:References:From;
        b=G++yily7En9IbJOYcRMMJJY9PBrSQFDViy2hX0ZSN0ErV+lrha27LH7gjUzVeiLRJ
         zyjGTJqHMDIdUueacLGe/qVD7f35bCWl9P7iSXuoWuBai64IeqPQXjWWxtHz/jod6Q
         6qogzkLzWzLgvQfOpbph9OUEGPadkoO5bWxb9IIk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201002122251eucas1p1c6de2006586529cb6ffe4aa4939d5933~6LFdwZ9N00997709977eucas1p16;
        Fri,  2 Oct 2020 12:22:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EF.32.06456.B9B177F5; Fri,  2
        Oct 2020 13:22:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201002122251eucas1p1a8977c163d7a291829e7cac212d26862~6LFdeAUWY0997709977eucas1p15;
        Fri,  2 Oct 2020 12:22:51 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201002122251eusmtrp13108e0b553244bbf3a2bc4cdda5520aa~6LFddRxLi1383613836eusmtrp10;
        Fri,  2 Oct 2020 12:22:51 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-8f-5f771b9b1b8b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3C.B0.06017.B9B177F5; Fri,  2
        Oct 2020 13:22:51 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201002122251eusmtip237723a5be5e592bda03c0c6f388c71f4~6LFdTShGG1143811438eusmtip2P;
        Fri,  2 Oct 2020 12:22:51 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?Bart=C5=82omiej=20=C5=BBo=C5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v3 0/9] Some fixes for spi-s3c64xx
Date:   Fri,  2 Oct 2020 14:22:34 +0200
Message-Id: <20201002122243.26849-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djP87qzpcvjDW7+lLNY/OM5k8XGGetZ
        LaY+fMJm0f/4NbPF+fMb2C1uHlrBaLHp8TVWi8u75rBZzDi/j8mi8eNNdou1R+6yW6za9YfR
        gcfj+pJPzB47Z91l99i0qpPNY/OSeo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DK2P9hPVPB
        XN6K2987WRoYn3J1MXJySAiYSGw/+pyli5GLQ0hgBaPEvmX7mSCcL4wSs3qOMEI4nxkl1m/c
        yAzTcuzDOzaIxHJGiUvbWqCqnjNKHJi8FKyKTcBRon/pCVaQhIjAdiaJiZ/Pg21hFjjKKLH5
        wVUWkCphASOJ1xsXA1VxcLAIqEqsuRgCEuYVsJaY+OYiI8Q6eYn25dvZIOKCEidnPgFr5RfQ
        kljTdB3MZgaqad46mxlkvoTAKXaJB+87oW51kfh++TMrhC0s8er4FnYIW0bi9OQeFpC9EgL1
        EpMnmUH09jBKbJvzgwWixlrizrlfbCA1zAKaEut36UOEHSVePG5ih2jlk7jxVhDiBD6JSdum
        M0OEeSU62oQgqlUk1vXvgRooJdH7agXUVx4St99fZpnAqDgLyWOzkDwzC2HvAkbmVYziqaXF
        uempxYZ5qeV6xYm5xaV56XrJ+bmbGIFp6vS/4592MH69lHSIUYCDUYmHN+NQabwQa2JZcWXu
        IUYJDmYlEV6ns6fjhHhTEiurUovy44tKc1KLDzFKc7AoifMaL3oZKySQnliSmp2aWpBaBJNl
        4uCUamAM97dhnSzzJ9/uxTTmiqy0Rr8PdpZsi0un9h8K9lnwgXHacZ4ym9PHy86t3/ex8KnF
        5iPJn/hD7O7+yCnI+7Jy72nBWwtWLT73eslbebFPd+9wp9cz/fEy2M2hIv1h5sKTB8qdPsuy
        LEn7ZujJkDBJVm7Pjl0bqqvuTLKKuj5PfeXcIk0vq19zlViKMxINtZiLihMB9NpGW08DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xe7qzpcvjDSa0cFss/vGcyWLjjPWs
        FlMfPmGz6H/8mtni/PkN7BY3D61gtNj0+BqrxeVdc9gsZpzfx2TR+PEmu8XaI3fZLVbt+sPo
        wONxfcknZo+ds+6ye2xa1cnmsXlJvUffllWMHp83yQWwRenZFOWXlqQqZOQXl9gqRRtaGOkZ
        WlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl7P+wnqlgLm/F7e+dLA2MT7m6GDk5JARM
        JI59eMfWxcjFISSwlFFixaYWxi5GDqCElMTKuekQNcISf651QdU8ZZT43tHNCpJgE3CU6F96
        ghUkISKwn0ni0oX7LCAOs8BhRonL69YxgVQJCxhJvN64mBVkKouAqsSaiyEgYV4Ba4mJby4y
        QmyQl2hfvp0NIi4ocXLmExaQcmYBdYn184RAwvwCWhJrmq6zgNjMQOXNW2czT2AUmIWkYxZC
        xywkVQsYmVcxiqSWFuem5xYb6RUn5haX5qXrJefnbmIExti2Yz+37GDsehd8iFGAg1GJh1fg
        QGm8EGtiWXFl7iFGCQ5mJRFep7On44R4UxIrq1KL8uOLSnNSiw8xmgJ9M5FZSjQ5Hxj/eSXx
        hqaG5haWhubG5sZmFkrivB0CB2OEBNITS1KzU1MLUotg+pg4OKUaGO0japdWzm4/277X1e+H
        y7G+b9vfXnscbdtrK++w8BZ3zdHnm3iPXhDY/dB/PsONr01bGgo75gRyis55xWIhfjpnZaBO
        EX9EyRQ23+y/C7QbNl48uKbvOpfk78zTz469XOq0tn9x118XnhtJkTwMeybHr54S//lT4dzw
        ZzP/f6jgKj/hzFJqKKHEUpyRaKjFXFScCADJrd6lxwIAAA==
X-CMS-MailID: 20201002122251eucas1p1a8977c163d7a291829e7cac212d26862
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201002122251eucas1p1a8977c163d7a291829e7cac212d26862
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201002122251eucas1p1a8977c163d7a291829e7cac212d26862
References: <CGME20201002122251eucas1p1a8977c163d7a291829e7cac212d26862@eucas1p1.samsung.com>
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
  spi: spi-s3c64xx: Check return values
  spi: spi-s3c64xx: Report more information when errors occur
  spi: spi-s3c64xx: Rename S3C64XX_SPI_SLAVE_* to S3C64XX_SPI_CS_*
  spi: spi-s3c64xx: Fix doc comment for struct s3c64xx_spi_driver_data
  spi: spi-s3c64xx: Ensure cur_speed holds actual clock value
  spi: spi-s3c64xx: Increase transfer timeout
  spi: spi-s3c64xx: Turn on interrupts upon resume

 drivers/spi/spi-s3c64xx.c | 111 +++++++++++++++++++++++++++-----------
 1 file changed, 79 insertions(+), 32 deletions(-)

Changes in v3:
  - added Reviewed-by and Suggested-by tags to commit messages
  - added information about non-CMU case in the commit message
    of (Ensure cur_speed holds actual clock value)

Changes in v2:
  - added missing commit descriptions
  - added spi: spi-s3c64xx: Ensure cur_speed holds actual clock value
  - implemented error propagation in
      spi: spi-s3c64xx: Check return values
  - rebased onto v5.9-rc1 which contains
      spi: spi-s3c64xx: Add missing entries for structs 's3c64xx_spi_dma_data' and 's3c64xx_spi_dma_data'
-- 
2.26.2

