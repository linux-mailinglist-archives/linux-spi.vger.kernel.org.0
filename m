Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09DB0151DCE
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2020 17:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgBDQGd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Feb 2020 11:06:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727290AbgBDQGd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Feb 2020 11:06:33 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 014FiTWa023326;
        Tue, 4 Feb 2020 11:06:27 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xxy9jdgs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 11:06:25 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 014Fj5ak027405;
        Tue, 4 Feb 2020 11:06:25 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xxy9jdgr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 11:06:25 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 014G4xDi005541;
        Tue, 4 Feb 2020 16:06:24 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 2xw0y6sb97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Feb 2020 16:06:24 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 014G6NYb33292792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Feb 2020 16:06:23 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70639112065;
        Tue,  4 Feb 2020 16:06:23 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8AB6112063;
        Tue,  4 Feb 2020 16:06:22 +0000 (GMT)
Received: from [9.163.68.178] (unknown [9.163.68.178])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Feb 2020 16:06:22 +0000 (GMT)
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
 <29f6cc86-69ca-bc88-b6ae-2b1a24c0dae3@linux.vnet.ibm.com>
 <CAHp75Vf3NCkbw39E+d_nf+AyViG2o-u5HxrCjXXmbGk4LaFLog@mail.gmail.com>
From:   Eddie James <eajames@linux.ibm.com>
Message-ID: <744f0019-8656-eec1-cb9a-7e70cd042587@linux.ibm.com>
Date:   Tue, 4 Feb 2020 10:06:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf3NCkbw39E+d_nf+AyViG2o-u5HxrCjXXmbGk4LaFLog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_05:2020-02-04,2020-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002040107
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 2/4/20 5:02 AM, Andy Shevchenko wrote:
> On Mon, Feb 3, 2020 at 10:33 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
>> On 1/30/20 10:37 AM, Andy Shevchenko wrote:
>>> On Wed, Jan 29, 2020 at 10:09 PM Eddie James <eajames@linux.ibm.com> wrote:
> ...
>
>>>> +       struct device *dev;
>>> Isn't fsl->dev the same?
>>> Perhaps kernel doc to explain the difference?
>>
>> No, it's not the same, as dev here is the SPI controller. I'll add a
>> comment.
> Why to have duplication then?


Nothing is being duplicated, the two variables are storing entirely 
different information, both of which are necessary for each SPI 
controller that this driver is driving.


>
>>>> +       struct fsi_device *fsi;
> ...
>
>>>> +       for (i = 0; i < num_bytes; ++i)
>>>> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);
>>> Redundant & 0xffULL part.
>>>
>>> Isn't it NIH of get_unalinged_be64 / le64 or something similar?
>>
>> No, these are shift in/out operations. The read register will also have
>> previous operations data in them and must be extracted with only the
>> correct number of bytes.
> Why not to call put_unaligned() how the tail in this case (it's 0 or
> can be easily made to be 0) will affect the result?


The shift-in is not the same as any byte-swap or unaligned operation. 
For however many bytes we've read, we start at that many bytes 
left-shifted in the register and copy out to our buffer, moving right 
for each next byte... I don't think there is an existing function for 
this operation.


>
>>>> +       return num_bytes;
>>>> +}
>>>> +static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
>>>> +{
>>> Ditto as for above function. (put_unaligned ...)
> Ditto.


I don't understand how this could work for transfers of less than 8 
bytes, any put_unaligned would access memory that it doesn't own.


>
>>>> +}
> ...
>
>>>> +static int fsi_spi_transfer_data(struct fsi_spi *ctx,
>>>> +                                struct spi_transfer *transfer)
>>>> +{
>>> Can you refactor to tx and rx parts?
>>
>> Why?
> It's way too long function to read. Indentation level also can improve
> readability.
> That's basically what refactoring is for.


The body is 65 lines, I don't think it is too long.

Since the function is used multiple times I think it makes more sense to 
encapsulate the check for tx/rx in the function rather than split it and 
have to check each time the functions are used.


>
>>>> +       return 0;
>>>> +}
> ...
>
>>>> +       if ((clock_cfg & (SPI_FSI_CLOCK_CFG_MM_ENABLE |
>>>> +                         SPI_FSI_CLOCK_CFG_ECC_DISABLE |
>>>> +                         SPI_FSI_CLOCK_CFG_MODE |
>>>> +                         SPI_FSI_CLOCK_CFG_SCK_RECV_DEL |
>>>> +                         SPI_FSI_CLOCK_CFG_SCK_DIV)) != wanted_clock_cfg)
>>>> +               rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
>>>> +                                      wanted_clock_cfg);
>>> Missed {} ?
>>
>> No? It's one line under the if.
> One statement, but *two* lines.
> What does checkpatch.pl tell you about this?


Right.

checkpatch.pl says nothing about this, I think it meets the coding 
standards as is.


Thanks for the review,

Eddie


>
