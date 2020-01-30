Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F054B14DDE0
	for <lists+linux-spi@lfdr.de>; Thu, 30 Jan 2020 16:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgA3PcV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Jan 2020 10:32:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10678 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727186AbgA3PcV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 Jan 2020 10:32:21 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00UFSulN110948;
        Thu, 30 Jan 2020 10:32:16 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrvwa4fd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jan 2020 10:32:14 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00UFVZLv006647;
        Thu, 30 Jan 2020 15:32:09 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 2xrda7g6sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jan 2020 15:32:09 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00UFW7NK36766184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jan 2020 15:32:07 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC97713604F;
        Thu, 30 Jan 2020 15:32:07 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C8D5136055;
        Thu, 30 Jan 2020 15:32:07 +0000 (GMT)
Received: from [9.163.57.149] (unknown [9.163.57.149])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jan 2020 15:32:07 +0000 (GMT)
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, andrew@aj.id.au
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <20200130144609.GD6682@sirena.org.uk>
From:   Eddie James <eajames@linux.ibm.com>
Message-ID: <3eaf74eb-1817-a04d-1fc9-146c188584d0@linux.ibm.com>
Date:   Thu, 30 Jan 2020 09:32:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200130144609.GD6682@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-30_04:2020-01-28,2020-01-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=952 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001300111
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 1/30/20 8:46 AM, Mark Brown wrote:
> On Wed, Jan 29, 2020 at 02:08:24PM -0600, Eddie James wrote:
>
> Overall this looks good, some comments below but they're all fairly
> minor.


Thanks for the quick review! I'll fix what you've suggested below.

Thanks,

Eddie


>
>> +++ b/drivers/spi/spi-fsi.c
>> @@ -0,0 +1,547 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) IBM Corporation 2020
>> + */
> Please make the entire comment a C++ one so things look more
> intentional.
>
>> +
>> +static int fsi_spi_data_in(u64 in, u8 *rx, int len)
>> +{
>> +	int i;
>> +	int num_bytes = len > 8 ? 8 : len;
> Please write normal conditional statements to improve legibility, the
> ternery operator isn't really needed here.
>
>> +static int fsi_spi_reset(struct fsi_spi *ctx)
>> +{
>> +	int rc;
>> +
>> +	dev_info(ctx->dev, "Resetting SPI controller.\n");
> This should be lowered to dev_dbg() at most, it's not really adding
> anything otherwise.
>
>> +static int fsi_spi_remove(struct device *dev)
>> +{
>> +	return 0;
>> +}
> Remove empty functions, if they can safely be empty then it should be
> possible to omit them.
>
>> +static const struct fsi_device_id fsi_spi_ids[] = {
>> +	{ FSI_ENGID_SPI, FSI_VERSION_ANY },
>> +	{ }
>> +};
> This needs a MODULE_DEVICE_TABLE annotation.
