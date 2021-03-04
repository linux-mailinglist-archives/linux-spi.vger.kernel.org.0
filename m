Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A0932D3FC
	for <lists+linux-spi@lfdr.de>; Thu,  4 Mar 2021 14:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbhCDNO7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Mar 2021 08:14:59 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44584 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241179AbhCDNOp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Mar 2021 08:14:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 124CnnEs131670;
        Thu, 4 Mar 2021 13:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=R562JOLzTjTOBlvS9isvPcEBbfWxb/+5B82DTC5j09s=;
 b=oolEGxOH2oI98kOpPSd8zskmwsHCA6NddZai89CCHF5K/opTpTduRS3V1MYbArsXStpo
 79NfsnSUpxZbqmlrxS3mnEtAic4NfdjqZ5aw/P4sPS4rygt/j1GMtEYN8x7FBrcR+Gfg
 M84TplISWVobmiFKXJBN0n97q6k8OGiLcuIcAzXSRAz+20QgRTzxthadB3ahhhpAIPr9
 3FgRPkNZcxD5ZUkQ1zrR+TI99+W3JWpYZUaKtEzEBGIVvMpvLODTZ27bwAMOPNU1hwW7
 CuW543AMHS84hYTLas7KgPHZt6LOThRsS5k2VUHofyuqCcIJhnn1JOa6mEIf5lUSO20t kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 371hhc8bax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Mar 2021 13:08:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 124Cp8Ka059649;
        Thu, 4 Mar 2021 13:08:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 370002mu5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Mar 2021 13:08:56 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 124D8rLK032470;
        Thu, 4 Mar 2021 13:08:53 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Mar 2021 13:08:52 +0000
Date:   Thu, 4 Mar 2021 16:08:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jay Fang <f.fangjian@huawei.com>
Cc:     linux-spi@vger.kernel.org, broonie@kernel.org,
        huangdaode@huawei.com
Subject: Re: [PATCH] spi: cadence-quadspi: Silence shiftTooManyBitsSigned
 warning
Message-ID: <20210304130845.GE2222@kadam>
References: <1614854872-8694-1-git-send-email-f.fangjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614854872-8694-1-git-send-email-f.fangjian@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040060
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9912 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040060
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 04, 2021 at 06:47:52PM +0800, Jay Fang wrote:
> drivers/spi/spi-cadence-quadspi.c:267:18: warning: Shifting signed 32-bit
> value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
>     return reg & (1 << CQSPI_REG_CONFIG_IDLE_LSB);
>                     ^
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Jay Fang <f.fangjian@huawei.com>
> ---
>  drivers/spi/spi-cadence-quadspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 442cc7c..9a2798a5 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -264,7 +264,7 @@ static bool cqspi_is_idle(struct cqspi_st *cqspi)
>  {
>  	u32 reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
>  
> -	return reg & (1 << CQSPI_REG_CONFIG_IDLE_LSB);
> +	return reg & (1UL << CQSPI_REG_CONFIG_IDLE_LSB);

This is always going to be false because reg is a u32.

regards,
dan carpenter

