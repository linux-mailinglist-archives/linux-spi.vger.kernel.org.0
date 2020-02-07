Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 902B1155E97
	for <lists+linux-spi@lfdr.de>; Fri,  7 Feb 2020 20:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBGT2s (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Feb 2020 14:28:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726900AbgBGT2s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Feb 2020 14:28:48 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 017JEwWv091196;
        Fri, 7 Feb 2020 14:28:43 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y0ktsu67d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 14:28:43 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 017JFNjU092205;
        Fri, 7 Feb 2020 14:28:42 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y0ktsu672-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 14:28:42 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 017JPobF027215;
        Fri, 7 Feb 2020 19:28:41 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 2xykca5kvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 19:28:41 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 017JSf0354591802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 7 Feb 2020 19:28:41 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1008D2805A;
        Fri,  7 Feb 2020 19:28:41 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 913DA28059;
        Fri,  7 Feb 2020 19:28:40 +0000 (GMT)
Received: from [9.41.103.158] (unknown [9.41.103.158])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  7 Feb 2020 19:28:40 +0000 (GMT)
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
 <29f6cc86-69ca-bc88-b6ae-2b1a24c0dae3@linux.vnet.ibm.com>
 <CAHp75Vf3NCkbw39E+d_nf+AyViG2o-u5HxrCjXXmbGk4LaFLog@mail.gmail.com>
 <744f0019-8656-eec1-cb9a-7e70cd042587@linux.ibm.com>
 <CAHp75VfOM5Rd3LRBtvyT96G=+J4KxTRoSVUcQTj+RxrGyZMMnQ@mail.gmail.com>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Message-ID: <90973143-bd0a-33cf-9eb8-a83be1a9b415@linux.vnet.ibm.com>
Date:   Fri, 7 Feb 2020 13:28:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfOM5Rd3LRBtvyT96G=+J4KxTRoSVUcQTj+RxrGyZMMnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-07_04:2020-02-07,2020-02-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002070139
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 2/5/20 9:51 AM, Andy Shevchenko wrote:
> On Tue, Feb 4, 2020 at 6:06 PM Eddie James <eajames@linux.ibm.com> wrote:
>> On 2/4/20 5:02 AM, Andy Shevchenko wrote:
>>> On Mon, Feb 3, 2020 at 10:33 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
>>>> On 1/30/20 10:37 AM, Andy Shevchenko wrote:
>>>>> On Wed, Jan 29, 2020 at 10:09 PM Eddie James <eajames@linux.ibm.com> wrote:
> ...
>
>>>>>> +       struct device *dev;
>>>>> Isn't fsl->dev the same?
>>>>> Perhaps kernel doc to explain the difference?
>>>> No, it's not the same, as dev here is the SPI controller. I'll add a
>>>> comment.
>>> Why to have duplication then?
>>
>> Nothing is being duplicated, the two variables are storing entirely
>> different information, both of which are necessary for each SPI
>> controller that this driver is driving.
> Oh, I see now, thanks!
>
> ...
>
>>>>>> +       for (i = 0; i < num_bytes; ++i)
>>>>>> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);
>>>>> Redundant & 0xffULL part.
>>>>>
>>>>> Isn't it NIH of get_unalinged_be64 / le64 or something similar?
>>>> No, these are shift in/out operations. The read register will also have
>>>> previous operations data in them and must be extracted with only the
>>>> correct number of bytes.
>>> Why not to call put_unaligned() how the tail in this case (it's 0 or
>>> can be easily made to be 0) will affect the result?
>>
>> The shift-in is not the same as any byte-swap or unaligned operation.
>> For however many bytes we've read, we start at that many bytes
>> left-shifted in the register and copy out to our buffer, moving right
>> for each next byte... I don't think there is an existing function for
>> this operation.
> For me it looks like
>
>    u8 tmp[8];
>
>    put_unaligned_be64(in, tmp);
>    memcpy(rx, tmp, num_bytes);
>
> put_unaligned*() is just a method to unroll the value to the u8 buffer.
> See, for example, linux/unaligned/be_byteshift.h implementation.


Unforunately it is not the same. put_unaligned_be64 will take the 
highest 8 bits (0xff00000000000000) and move it into tmp[0]. Then 
0x00ff000000000000 into tmp[1], etc. This is only correct for this 
driver IF my transfer is 8 bytes. If, for example, I transfer 5 bytes, 
then I need 0x000000ff00000000 into tmp[0], 0x00000000ff000000 into 
tmp[1], etc. So I think my current implementation is correct.


Thanks,

Eddie


>
>>>>>> +       return num_bytes;
>>>>>> +}
>>>>>> +static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
>>>>>> +{
>>>>> Ditto as for above function. (put_unaligned ...)
>>> Ditto.
>>
>> I don't understand how this could work for transfers of less than 8
>> bytes, any put_unaligned would access memory that it doesn't own.
> Ditto.
>
>>>>>> +}
