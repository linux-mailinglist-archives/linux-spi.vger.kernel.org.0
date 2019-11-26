Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91617109FBD
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 15:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfKZOCb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Nov 2019 09:02:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43340 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727719AbfKZOCb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Nov 2019 09:02:31 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQDxMpj014966;
        Tue, 26 Nov 2019 14:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=0KmEc5xPHzqBJVfLF5aZg5q51UGChEdbv2XLgUktmpM=;
 b=boUgzl5nwQxhp6UPWxDqvbKRCbefx/ibarVNgJtjx/rqJ0xtHAc+4RHIHE9SrvhYjNoj
 8nBRAz+B55X8KEwM9WhMXtE9Oc5aff35JOuA5Obxh24R7zMvvo467vBysDDmRtX/bsxh
 SVLNMS2+hyihhG4118M+0ZdW1L4NIEZ8RgMPC8mPcYjjP9+vVyhJU402OK3F6JL0/nmd
 A6ptNdiTV2m60CNH7Gg5vcoEloKtXwmjvh40gVcgki8MMygah84beUbE/x+wxtARqJGz
 4zgLYqbC8HdRJe8M4e8bFxTaLsx9UG/EojPxKsMXQh3lhl1opt7DLJ441KVmGf3A03fj sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wev6u6yp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 14:02:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQDwuBU073881;
        Tue, 26 Nov 2019 14:02:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2wh0rbw7ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 14:02:21 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAQE2Jbk031353;
        Tue, 26 Nov 2019 14:02:19 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Nov 2019 06:02:19 -0800
Date:   Tue, 26 Nov 2019 17:02:12 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: pic32: Add a comment in pic32_spi_dma_prep()
Message-ID: <20191126140212.GC1759@kadam>
References: <20191126135025.mligekonmv2u6dcl@kili.mountain>
 <67ddc7f2-c67e-708b-0932-af425db04604@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ddc7f2-c67e-708b-0932-af425db04604@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911260126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911260126
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 26, 2019 at 03:55:25PM +0200, Peter Ujfalusi wrote:
> Hi Dan,
> 
> On 26/11/2019 15.50, Dan Carpenter wrote:
> > This code triggers a static checker warning about missed error codes.
> > It's slightly tricky that we fall back to PIO so let's silence the
> > checker and add a comment for anyone who is confused.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > I won't feel offended at all if people don't think it's worth applying
> > this patch.
> > 
> >  drivers/spi/spi-pic32.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
> > index 156961b4ca86..835380ab8bf2 100644
> > --- a/drivers/spi/spi-pic32.c
> > +++ b/drivers/spi/spi-pic32.c
> > @@ -633,8 +633,10 @@ static int pic32_spi_dma_prep(struct pic32_spi *pic32s, struct device *dev)
> >  		goto out_err;
> >  	}
> >  
> > -	if (pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE))
> > +	if (pic32_spi_dma_config(pic32s, DMA_SLAVE_BUSWIDTH_1_BYTE)) {
> > +		ret = 0;  /* Fall back to PIO if DMA fails. */
> 
> The 'ret' is initialized to 0 in the function to handle this.
> After looking at the code again I see that pic32_spi_dma_config() does
> error prints for failures.
> 
> A comment might be enough here if it is even needed.

Yeah.  The "ret = 0;" is just to silence static checkers.  It doesn't
change the object code (except line numbers).  I'm not emotionally
invested in this patch so if it's too much then that's fine.

regards,
dan carpenter
