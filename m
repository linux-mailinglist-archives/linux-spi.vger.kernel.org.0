Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28AE3109F8E
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 14:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfKZNvk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Nov 2019 08:51:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55860 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfKZNvk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Nov 2019 08:51:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQDp1dI006493;
        Tue, 26 Nov 2019 13:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=7yJkXZVLo+rQD+I2GCanRtU1zAWl5iCI0qmDBmeoVQM=;
 b=l925XKIYIJFXM0HQdqAHS/rG3ajWwLwwCRVbcv/luUq63nFQ5XIf+ytg7oqWPugS80+G
 4vU3mUx76Hlq5pky6Ts1LOXQPacYzPIddQ4WHa7WjpKypU99AaWG4ShnPz0lkUAb+RnW
 5ZjmIsvbbaMsxKK0OR7TrIuOgz1oHrtvqZ8eMiz0fruyeVbHqInT6A/63IkxYhduSYqV
 6CxEe6+JfvaGxNCk3D4u3WZuF4CX6aFA+jm1i9N/0TetydUo+7rwN+zg/dJSumqFS1kh
 exwKraSQDcFLzIcvFrw0XlhmDqJXoGfJ21uF52uGDxiec0PBiUzP/Ff1ZTaccbS/IiBS /w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wev6u6w4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 13:51:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAQDmNYQ047344;
        Tue, 26 Nov 2019 13:51:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2wh0rbu8r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Nov 2019 13:51:24 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAQDpNtb024515;
        Tue, 26 Nov 2019 13:51:23 GMT
Received: from kadam (/129.205.23.165) by default (Oracle Beehive Gateway
 v4.0) with ESMTP ; Tue, 26 Nov 2019 05:51:00 -0800
USER-AGENT: Mutt/1.9.4 (2018-02-28)
MIME-Version: 1.0
Message-ID: <20191126135051.GB1759@kadam>
Date:   Tue, 26 Nov 2019 13:50:52 +0000 (UTC)
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: pic32: Fix an error code in pic32_spi_dma_prep()
References: <20191126122324.v3rj7oscvjobhjxo@kili.mountain>
 <CAMuHMdX52phf_dSQh3vK8QGJtvmUwDiY_0f6d7xAJ_xF2vKNfg@mail.gmail.com>
 <a22ba950-f65b-b80e-948a-eddfa0a7d431@ti.com>
In-Reply-To: <a22ba950-f65b-b80e-948a-eddfa0a7d431@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=771
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911260124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9452 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=833 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911260124
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Ah.  Thanks Peter.

regards,
dan carpenter

