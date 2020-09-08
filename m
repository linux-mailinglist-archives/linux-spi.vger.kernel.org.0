Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C462260BE2
	for <lists+linux-spi@lfdr.de>; Tue,  8 Sep 2020 09:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgIHHYM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 8 Sep 2020 03:24:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41452 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgIHHYL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 8 Sep 2020 03:24:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0887KfjK191737;
        Tue, 8 Sep 2020 07:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=gyNG/z52yC4UbBO7N5gXxAxC0y63SC6dWM/W1DzFqA0=;
 b=Xghr8kPClvO87QKFCs3M0W6d01djfl7lJZuk5LiOlheMiobPMSo/u0lT+JRtLhq7yKU3
 8AtItc4o2ubgsGMpAkFnusjjjrrCiaBrw9Z95TybHFOEdIptjWr4LF53IlQMipEpeTII
 /kn5gPL0U0FtfLga3jS0rct2mN0JHmIcSfPZ4zjdhEX/tDJzkiDn8PnLSpqqXPYXcLRH
 Lm5qacdF5XpXFlzejgKMhlWjC3HmGDGMEma8OBj/FCsvDKE1BXzAh0KfeKmsYK9cJiFo
 nw93hfDVe2l0i1PLU2nWSBCjmKFyvNLOvrL2aZUUFNYX/oU2nvQt3uZNwdhXDY0G+7Uy NQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33c2mksgt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 08 Sep 2020 07:24:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0887KGd1092160;
        Tue, 8 Sep 2020 07:24:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33cmkvfe2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Sep 2020 07:24:06 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0887O65s023370;
        Tue, 8 Sep 2020 07:24:06 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Sep 2020 00:24:05 -0700
Date:   Tue, 8 Sep 2020 10:24:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     andrew.smirnov@gmail.com,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     linux-spi@vger.kernel.org
Subject: [bug report] spi: gpio: Use devm_spi_register_master()
Message-ID: <20200908072400.GB294938@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9737 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=5
 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009080068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9737 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 suspectscore=5 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009080068
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Andrey Smirnov,

The patch 79567c1a321e: "spi: gpio: Use devm_spi_register_master()"
from Apr 2, 2019, leads to the following static checker warning:

	drivers/spi/spi-gpio.c:435 spi_gpio_probe()
	warn: 'master->dev.kobj' not decremented on lines: 435.

drivers/spi/spi-gpio.c
   358  static int spi_gpio_probe(struct platform_device *pdev)
   359  {
   360          int                             status;
   361          struct spi_master               *master;
   362          struct spi_gpio                 *spi_gpio;
   363          struct device                   *dev = &pdev->dev;
   364          struct spi_bitbang              *bb;
   365  
   366          master = spi_alloc_master(dev, sizeof(*spi_gpio));
   367          if (!master)
   368                  return -ENOMEM;
   369  
   370          status = devm_add_action_or_reset(&pdev->dev, spi_gpio_put, master);
   371          if (status) {
   372                  spi_master_put(master);
                        ^^^^^^^^^^^^^^^^^^^^^^
The devm_add_action_or_reset() function calls spi_gpio_put() on error
so this seems like a double free.

   373                  return status;
   374          }
   375  
   376          if (pdev->dev.of_node)
   377                  status = spi_gpio_probe_dt(pdev, master);
   378          else
   379                  status = spi_gpio_probe_pdata(pdev, master);
   380  
   381          if (status)
   382                  return status;
   383  
   384          spi_gpio = spi_master_get_devdata(master);
   385  
   386          status = spi_gpio_request(dev, spi_gpio);
   387          if (status)
   388                  return status;
   389  
   390          master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
   391          master->mode_bits = SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPOL |
   392                              SPI_CS_HIGH;
   393          if (!spi_gpio->mosi) {
   394                  /* HW configuration without MOSI pin
   395                   *
   396                   * No setting SPI_MASTER_NO_RX here - if there is only
   397                   * a MOSI pin connected the host can still do RX by
   398                   * changing the direction of the line.
   399                   */
   400                  master->flags = SPI_MASTER_NO_TX;
   401          }
   402  
   403          master->bus_num = pdev->id;
   404          master->setup = spi_gpio_setup;
   405          master->cleanup = spi_gpio_cleanup;
   406  
   407          bb = &spi_gpio->bitbang;
   408          bb->master = master;
   409          /*
   410           * There is some additional business, apart from driving the CS GPIO
   411           * line, that we need to do on selection. This makes the local
   412           * callback for chipselect always get called.
   413           */
   414          master->flags |= SPI_MASTER_GPIO_SS;
   415          bb->chipselect = spi_gpio_chipselect;
   416          bb->set_line_direction = spi_gpio_set_direction;
   417  
   418          if (master->flags & SPI_MASTER_NO_TX) {
   419                  bb->txrx_word[SPI_MODE_0] = spi_gpio_spec_txrx_word_mode0;
   420                  bb->txrx_word[SPI_MODE_1] = spi_gpio_spec_txrx_word_mode1;
   421                  bb->txrx_word[SPI_MODE_2] = spi_gpio_spec_txrx_word_mode2;
   422                  bb->txrx_word[SPI_MODE_3] = spi_gpio_spec_txrx_word_mode3;
   423          } else {
   424                  bb->txrx_word[SPI_MODE_0] = spi_gpio_txrx_word_mode0;
   425                  bb->txrx_word[SPI_MODE_1] = spi_gpio_txrx_word_mode1;
   426                  bb->txrx_word[SPI_MODE_2] = spi_gpio_txrx_word_mode2;
   427                  bb->txrx_word[SPI_MODE_3] = spi_gpio_txrx_word_mode3;
   428          }
   429          bb->setup_transfer = spi_bitbang_setup_transfer;
   430  
   431          status = spi_bitbang_init(&spi_gpio->bitbang);
   432          if (status)
   433                  return status;
   434  
   435          return devm_spi_register_master(&pdev->dev, spi_master_get(master));
                                                            ^^^^^^^^^^^^^^^^^^^^^^
Why are we taking a second reference here?  Where will it be released?

   436  }

regards,
dan carpenter
