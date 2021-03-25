Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F2334947C
	for <lists+linux-spi@lfdr.de>; Thu, 25 Mar 2021 15:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCYOrW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Mar 2021 10:47:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42027 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230516AbhCYOqz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Mar 2021 10:46:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12PEYBML098004;
        Thu, 25 Mar 2021 10:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hMRXH087zI/b5nC44YarlVd0OaxhzgeHqlahxSuBjMY=;
 b=nzUl5e5LD1HtLz7KcIo0gb02Ih4FsXy+eDaL2W+FwNH6agvw5gLUHJfZX+YWqNFZu0TM
 mzlz3tOOAWn+CyvGCht9Bi3xU4DmdTneAjUsPWa8v5i0ZQx5v/TW3uPZnkpXvMJBZOHx
 pgiucLeJb1Rlj6Y+ATRH5wBfablOkPPrKI4u7XPtlvcleoQjuHG8Xzwm7TI8jNlbjxi9
 gyFjM3E6iFfr7VzvPgI5aM8n1MtI06NgfWFolaga5koIOfNdCh+FPZeoBas572O3DUb/
 RFPdgJtr3Z+IGCX9AG3CM9mbQpy1Hjv24TkZF+bR578B7wu6+e8gcW2RA+jGaYrMQzh9 gQ== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 37gq0bahus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Mar 2021 10:46:52 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12PEYSuh008636;
        Thu, 25 Mar 2021 14:46:52 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 37d99rpean-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Mar 2021 14:46:52 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12PEkpRA34537788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 14:46:51 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86EDD136055;
        Thu, 25 Mar 2021 14:46:51 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C5B2136060;
        Thu, 25 Mar 2021 14:46:51 +0000 (GMT)
Received: from v0005c16 (unknown [9.211.54.31])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 25 Mar 2021 14:46:51 +0000 (GMT)
Message-ID: <d79291deaa1e9960a177dd887884724f22eb0ea6.camel@linux.ibm.com>
Subject: Re: [PATCH] spi: fsi: Remove multiple sequenced ops for restricted
 chips
From:   Eddie James <eajames@linux.ibm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au
Date:   Thu, 25 Mar 2021 09:46:50 -0500
In-Reply-To: <20210325135038.GA4620@sirena.org.uk>
References: <20210324220516.41192-1-eajames@linux.ibm.com>
         <20210325135038.GA4620@sirena.org.uk>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-25_03:2021-03-24,2021-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=835 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250109
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 2021-03-25 at 13:50 +0000, Mark Brown wrote:
> On Wed, Mar 24, 2021 at 05:05:16PM -0500, Eddie James wrote:
> 
> > Updated restricted chips have trouble processing multiple sequenced
> > operations. So remove the capability to sequence multiple
> > operations and
> > reduce the maximum transfer size to 8 bytes.
> 
> That's a very small limit, it would be nice to be able to identify
> devices that can use the larger limit so they don't suffer
> needlessly.

Yes, this is only for the "restricted" controllers which are marked by
a different compatible string. I guess the commit message isn't
perfectly clear.

Thanks,
Eddie


