Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9050C2EEA
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 10:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfJAIdi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 04:33:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37838 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfJAIdi (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Oct 2019 04:33:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x918V1bH185044;
        Tue, 1 Oct 2019 08:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=0SP0/Sx5shuQN7T9uvZ4B0zC0t8O0A0te3GAtBReFzY=;
 b=BQVDhAc5HEG+57taXODlLmDt/qcfahkMXKt8k/DtdDmamTrZ4anI5hWyganjfg6C8pc2
 Yd2sbbGBL3g5XlaSrbsSbU/UtfdsBhNUIsSLn6yRydpdL6ysdpgTd90VHx0XPpcTaNub
 PEDDYZzZV4yru8W1nIm/NYvOeEtB/VNC4hiYTfsyrVwr56WByWzHlNPOy8mrh/JRPjRf
 REwk8gO23+NzRJWkBVI602Ai3LW99+W81KfjzwGJYVKfYQwjDFp9LDccVy4+Yf2KJLZz
 y22FuCBiMpPL6LnBsfgqcxn77GeR7ds4Wor+4fEo93B6x9VuxPCepVCdzv+czCiqYfIV JA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2va05rm399-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 08:33:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x918XLQH157490;
        Tue, 1 Oct 2019 08:33:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2vbsm1jefv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 08:33:30 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x918WkMn009048;
        Tue, 1 Oct 2019 08:32:46 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 01 Oct 2019 01:32:46 -0700
Date:   Tue, 1 Oct 2019 11:32:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     lukma@denx.de
Cc:     linux-spi@vger.kernel.org
Subject: [bug report] spi: Add call to spi_slave_abort() function when spidev
 driver is released
Message-ID: <20191001083240.GA20116@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=797
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010083
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=881 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010082
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Lukasz Majewski,

The patch 9f918a728cf8: "spi: Add call to spi_slave_abort() function
when spidev driver is released" from Sep 25, 2019, leads to the
following static checker warning:

    drivers/spi/spidev.c:631 spidev_release()
    error: dereferencing freed memory 'spidev'

    drivers/spi/spidev.c:631 spidev_release()
    error: we previously assumed 'spidev->spi' could be null (see line 624)

drivers/spi/spidev.c
   600  static int spidev_release(struct inode *inode, struct file *filp)
   601  {
   602          struct spidev_data      *spidev;
   603  
   604          mutex_lock(&device_list_lock);
   605          spidev = filp->private_data;
   606          filp->private_data = NULL;
   607  
   608          /* last close? */
   609          spidev->users--;
   610          if (!spidev->users) {
   611                  int             dofree;
   612  
   613                  kfree(spidev->tx_buffer);
   614                  spidev->tx_buffer = NULL;
   615  
   616                  kfree(spidev->rx_buffer);
   617                  spidev->rx_buffer = NULL;
   618  
   619                  spin_lock_irq(&spidev->spi_lock);
   620                  if (spidev->spi)
   621                          spidev->speed_hz = spidev->spi->max_speed_hz;
   622  
   623                  /* ... after we unbound from the underlying device? */
   624                  dofree = (spidev->spi == NULL);
                                  ^^^^^^^^^^^^^^^^^^^
This can be NULL

   625                  spin_unlock_irq(&spidev->spi_lock);
   626  
   627                  if (dofree)
   628                          kfree(spidev);
                                      ^^^^^^
and this is freed

   629          }
   630  #ifdef CONFIG_SPI_SLAVE
   631          spi_slave_abort(spidev->spi);
                                ^^^^^^^^^^^
So there is a potential issue here.  spi_slave_abort() dereferences
"spidev->spi" without checking for NULL.

   632  #endif
   633          mutex_unlock(&device_list_lock);
   634  
   635          return 0;
   636  }

regards,
dan carpenter
