Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AC432E51C
	for <lists+linux-spi@lfdr.de>; Fri,  5 Mar 2021 10:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhCEJnZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Mar 2021 04:43:25 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46662 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhCEJnF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Mar 2021 04:43:05 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1259TIqx186143;
        Fri, 5 Mar 2021 09:42:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=PCNF0maNKEy5JAKfPPEFutJHU2aFpiWvTLmNBjcWJGs=;
 b=gvHZ0oPYQjb0Bcp1bN0RGnawa7vAgd8Bo/RbcI1FSmJSsmkueoGGoDY964LoY9slhgr0
 5JfkDOSfZwSYNn1BrQ9rO4EgESUWLMnz7ChNTg2sE25NYh4o+gA7bBmgi+zDqrl4eUhC
 kMuvkB4qaNdTdbLR3KD8DfECgKESaEfd0ciOdrH9AJr9lsSKXlGrhZ5/BE2r01xe4yf+
 capvmOexNp260UDq+1zggdaLzY7VQM0UL5cQBhHnR0zMgvS+lU9T4iCPky7ci5KwSzID
 Rn2TfBg6pkfBTrwxVJ51m2Ao9Sq3U3kZFvzUbBuxsqoA0vSNfFOOynzoORFY6GYo4Tjq PA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 36ybkbhy52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Mar 2021 09:42:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1259V9IP082732;
        Fri, 5 Mar 2021 09:42:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3700121a2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Mar 2021 09:42:52 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1259goug017448;
        Fri, 5 Mar 2021 09:42:50 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Mar 2021 09:42:49 +0000
Date:   Fri, 5 Mar 2021 12:42:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Jay Fang <f.fangjian@huawei.com>, linux-spi@vger.kernel.org,
        broonie@kernel.org, huangdaode@huawei.com
Subject: Re: [PATCH] spi: cadence-quadspi: Silence shiftTooManyBitsSigned
 warning
Message-ID: <20210305094242.GH2222@kadam>
References: <1614854872-8694-1-git-send-email-f.fangjian@huawei.com>
 <20210304130845.GE2222@kadam>
 <20210304193427.rdtu75tv6invjq2d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304193427.rdtu75tv6invjq2d@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103050046
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9913 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050046
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Mar 05, 2021 at 01:04:27AM +0530, Pratyush Yadav wrote:
> On 04/03/21 04:08PM, Dan Carpenter wrote:
> > On Thu, Mar 04, 2021 at 06:47:52PM +0800, Jay Fang wrote:
> > > drivers/spi/spi-cadence-quadspi.c:267:18: warning: Shifting signed 32-bit
> > > value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
> > >     return reg & (1 << CQSPI_REG_CONFIG_IDLE_LSB);
> > >                     ^
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Jay Fang <f.fangjian@huawei.com>
> > > ---
> > >  drivers/spi/spi-cadence-quadspi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> > > index 442cc7c..9a2798a5 100644
> > > --- a/drivers/spi/spi-cadence-quadspi.c
> > > +++ b/drivers/spi/spi-cadence-quadspi.c
> > > @@ -264,7 +264,7 @@ static bool cqspi_is_idle(struct cqspi_st *cqspi)
> > >  {
> > >  	u32 reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
> > >  
> > > -	return reg & (1 << CQSPI_REG_CONFIG_IDLE_LSB);
> > > +	return reg & (1UL << CQSPI_REG_CONFIG_IDLE_LSB);
> > 
> > This is always going to be false because reg is a u32.
> 
> Hmm... I don't see why it would always be false. reg would promoted to 
> unsigned long and the result should then depend on the actual value of 
> the bit, which can be represented by an unsigned long. There is no loss 
> of information.
> 
> Anyway, it still makes more sense to make it 1U because reg is u32. Just 
> keep the types same and avoid all the conversion rules.

Ah, crap.  I'm sorry.  I somehow thought when I forwarded this bug the
other day that CQSPI_REG_CONFIG_IDLE_LSB was more than 31.

regards,
dan carpenter

