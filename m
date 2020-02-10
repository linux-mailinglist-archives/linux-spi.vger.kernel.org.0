Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53CA9158466
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2020 21:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgBJUu2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Feb 2020 15:50:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17766 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgBJUu2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Feb 2020 15:50:28 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AKmjgO085744;
        Mon, 10 Feb 2020 15:50:23 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1u56b3u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 15:50:22 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01AKoMWW092177;
        Mon, 10 Feb 2020 15:50:22 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1u56b3te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 15:50:22 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01AKi7qh015094;
        Mon, 10 Feb 2020 20:50:21 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 2y1mm6nstf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 20:50:21 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01AKoJTS12779818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 20:50:19 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C8C26A07B;
        Mon, 10 Feb 2020 20:50:18 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46E4C6A066;
        Mon, 10 Feb 2020 20:50:18 +0000 (GMT)
Received: from [9.41.103.158] (unknown [9.41.103.158])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 10 Feb 2020 20:50:18 +0000 (GMT)
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Eddie James <eajames@linux.ibm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
 <29f6cc86-69ca-bc88-b6ae-2b1a24c0dae3@linux.vnet.ibm.com>
 <CAHp75Vf3NCkbw39E+d_nf+AyViG2o-u5HxrCjXXmbGk4LaFLog@mail.gmail.com>
 <744f0019-8656-eec1-cb9a-7e70cd042587@linux.ibm.com>
 <CAHp75VfOM5Rd3LRBtvyT96G=+J4KxTRoSVUcQTj+RxrGyZMMnQ@mail.gmail.com>
 <90973143-bd0a-33cf-9eb8-a83be1a9b415@linux.vnet.ibm.com>
 <CAHp75Vf6HJw=SpK9_HUgcMaaabs5pZEybP4SS-gc1wz5GRcqeg@mail.gmail.com>
 <cd8a7279-beb2-39e6-58e6-6ea505665547@linux.vnet.ibm.com>
 <CAHp75VdO2+Kkgo1Nv3EJXTMqP6Y7XgLVXtRvURk6Zz0p=R9zNQ@mail.gmail.com>
 <ca8a832e-ceeb-3ce1-9807-96ee41e0f166@linux.vnet.ibm.com>
 <CAHp75VduJn=kMuriGNAGk1ZrL4b2LpqEn5c8AC=PHFKrgoz=vg@mail.gmail.com>
 <3bbc98a7-838d-f57f-0478-a632ba68f500@linux.vnet.ibm.com>
 <CAHp75VfpRV7UDMpPKo8Vu1PaOfLjUG24yUdkg8ip9=923cwarA@mail.gmail.com>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Message-ID: <e9d8ebd0-85da-307a-1e80-8cc25bd9454c@linux.vnet.ibm.com>
Date:   Mon, 10 Feb 2020 14:50:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfpRV7UDMpPKo8Vu1PaOfLjUG24yUdkg8ip9=923cwarA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_07:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100149
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 2/10/20 2:33 PM, Andy Shevchenko wrote:
> On Mon, Feb 10, 2020 at 10:05 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
>> On 2/7/20 4:04 PM, Andy Shevchenko wrote:
>>> On Fri, Feb 7, 2020 at 11:04 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
>>>> On 2/7/20 2:34 PM, Andy Shevchenko wrote:
>>>>> On Fri, Feb 7, 2020 at 10:04 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
>>>>>> On 2/7/20 1:39 PM, Andy Shevchenko wrote:
>>>>>>> On Fri, Feb 7, 2020 at 9:28 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
>>>>>>>> On 2/5/20 9:51 AM, Andy Shevchenko wrote:
>>>>>>>>> On Tue, Feb 4, 2020 at 6:06 PM Eddie James <eajames@linux.ibm.com> wrote:
>>>>>>>>>> On 2/4/20 5:02 AM, Andy Shevchenko wrote:
>>>>>>>>>>> On Mon, Feb 3, 2020 at 10:33 PM Eddie James <eajames@linux.vnet.ibm.com> wrote:
>>>>>>>>>>>> On 1/30/20 10:37 AM, Andy Shevchenko wrote:
>>>>>>>>>>>>>> +       for (i = 0; i < num_bytes; ++i)
>>>>>>>>>>>>>> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);
>>>>>>>>>>>>> Redundant & 0xffULL part.
>>>>>>>>> For me it looks like
>>>>>>>>>
>>>>>>>>>        u8 tmp[8];
>>>>>>>>>
>>>>>>>>>        put_unaligned_be64(in, tmp);
>>>>>>>>>        memcpy(rx, tmp, num_bytes);
>>>>>>>>>
>>>>>>>>> put_unaligned*() is just a method to unroll the value to the u8 buffer.
>>>>>>>>> See, for example, linux/unaligned/be_byteshift.h implementation.
>>>>>>>> Unforunately it is not the same. put_unaligned_be64 will take the
>>>>>>>> highest 8 bits (0xff00000000000000) and move it into tmp[0]. Then
>>>>>>>> 0x00ff000000000000 into tmp[1], etc. This is only correct for this
>>>>>>>> driver IF my transfer is 8 bytes. If, for example, I transfer 5 bytes,
>>>>>>>> then I need 0x000000ff00000000 into tmp[0], 0x00000000ff000000 into
>>>>>>>> tmp[1], etc. So I think my current implementation is correct.
>>>>>>> Yes, I missed correction of the start address in memcpy(). Otherwise
>>>>>>> it's still the same what I was talking about.
>>>>>> I see now, yes, thanks.
>>>>>>
>>>>>> Do you think this is worth a v3? Perhaps put_unaligned is slightly more
>>>>>> optimized than the loop but there is more memory copy with that way too.
>>>>> I already forgot the entire context when this has been called. Can you
>>>>> summarize what the sequence(s) of num_bytes are expected usually.
>>>>>
>>>>> IIUC if packets small, less than 8 bytes, than num_bytes will be that value.
>>>>> Otherwise it will be something like 8 + 8 + 8 ... + tail. Is it
>>>>> correct assumption?
>>>> Yes, it will typically be 8 + 8 +... remainder. Basically, on any RX,
>>>> the driver polls for the rx register full. Once full, it will read
>>>> however much data is left to be transferred. Since we use min(len, 8)
>>>> then we read 8 usually, until we get to the end.
>>> I asked that because we might have a better optimization, i.e, call
>>> directly put_unaligned_be64() when we know that length is 8 bytes. For
>>> the rest your approach might be simpler. Similar for the TX case.
>>
>> I just tried to implement as you suggested but I realized something: The
>> value is already swapped from BE to CPU when the register is read in
>> fsi_spi_read_reg. It happens to work out correctly to use
>> put_unaligned_be64 on a LE CPU to flip the bytes here. But on a BE CPU,
>> this wouldn't be correct I think.
> Hmm... Any BE conversion op on BE architecture is no-op.
> Same for LE on LE.


Right. So regardless of architecture, by the time we get to 
fsi_spi_data_in, the data is in the correct endianness. But on a BE 
architecture, it would still need to get flipped because that's what the 
specification indicates. So doing it manually seems correct to me.


>
>> Now I don't anticipate this driver
>> running on a BE CPU, but I think it is weird to flip it twice, and
>> better to do it manually here.
>>
>> What do you think Andy?
>
>
>>>>>>>>>>>>>> +       return num_bytes;
>>>>>>>>>>>>>> +}
>
>
