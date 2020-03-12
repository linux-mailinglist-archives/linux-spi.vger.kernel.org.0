Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3C011837F4
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 18:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgCLRr4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 13:47:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34888 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgCLRrz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Mar 2020 13:47:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CHdR0T092778;
        Thu, 12 Mar 2020 17:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=UES/joqIX5zBij1J5FtiE8fN/xECEN4Pix1GU2cbIAg=;
 b=TkYprmm9T3gmff9ZhMmP6V9w9fFeGx8sJStTMGaSgaPKfHaCfFUJCIUT1W/kWJ6u68lO
 i9gX3G8bLy8vkVQFeyBrUeVkmDL7hEnoYtJwXAHYBS/wpUAG9UwSBalxPGKYipDDrSIx
 NAcar9+9SGwN49aO56daaYBOnGEtA7AeQ8i+Ywo19zHkWkwHk57t0dNHkpEjXFJoTgw+
 i97EGSDrF0U8mlMeOwWaeK1F0GxI4nGCOuGTZzHTRHlfAwUOL/Amtz1qMzq60pTALJuD
 W65//Oy69LkCzaXxLc+ybh0jMdcnaVjRiOjcEWI5ARw91UezbemtlkFnwNmn7qtFoCGa kA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2yqkg8a8x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 17:47:49 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CHcR6o138571;
        Thu, 12 Mar 2020 17:47:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2yqkvn308f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 17:47:49 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CHlmEb012199;
        Thu, 12 Mar 2020 17:47:48 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 10:47:47 -0700
Date:   Thu, 12 Mar 2020 20:47:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     Yogesh Gaur <yogeshgaur.83@gmail.com>, Han Xu <han.xu@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] spi: spi-nxp-fspi: Fix a NULL vs IS_ERR() check in probe
Message-ID: <20200312125016.GF11583@kadam>
References: <20200312113154.GC20562@mwanda>
 <CAHCN7xKSc7spZyq=mySWHDmSrGMkQo8FYRbn-NzYRa7iB-0BoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xKSc7spZyq=mySWHDmSrGMkQo8FYRbn-NzYRa7iB-0BoQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9558 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120090
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Mar 12, 2020 at 06:58:31AM -0500, Adam Ford wrote:
> On Thu, Mar 12, 2020 at 6:32 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > The platform_get_resource_byname() function returns NULL on error, it
> > doesn't return error pointers.
> >
> > Fixes: d166a73503ef ("spi: fspi: dynamically alloc AHB memory")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > The commit message for commit d166a73503ef ("spi: fspi: dynamically
> > alloc AHB memory") is not very good.  Why is it necessary to allocate
> > the AHB memory dynamically instead of during probe?  Also I suspect that
> > Adam should have recieved authorship credit for that patch.
> 
> It wasn't my patch, I just pulled it in from NXP's repo.  The true
> author is Han Xu.  When I pulled in the series from NXP, I found the
> flexSPI on the i.MX8MM to become functional, and my company has a
> board with a qspi flash on it.

You should have put your Signed-off-by after Han Xu's.  They should be
in chronological order so whoever handles a patch adds their S-o-b to
the end.

regards,
dan carpenter

