Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4808118898
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 13:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfLJMji (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 07:39:38 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44070 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfLJMji (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 07:39:38 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBACdXG4024076;
        Tue, 10 Dec 2019 06:39:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575981573;
        bh=3xQj+7qgwlFxQtXkq3ZY21uhbciCc0MPgGBvv6nV+Qs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YNCBZe+fHoqUJWNtPLszQFiv5oODQeyoBBBX1vyFj1B575gv/QePDG+wygZXKA52K
         IhP3xrz+LG0JgVwBHuKC+V8c+EgGT1SsyHq7AOh3QtNh6i94dcU9L4p07w/evHL17W
         3BWWSpPqu0szoeyE5Lx02OS2Sr6gqCYWG/W5jLGI=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBACdXot106945
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Dec 2019 06:39:33 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Dec 2019 06:39:32 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Dec 2019 06:39:32 -0600
Received: from [172.24.145.136] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBACdTvK070701;
        Tue, 10 Dec 2019 06:39:30 -0600
Subject: Re: [PATCH 2/3] TI QSPI: support large flash devices
To:     Jean Pihet <jean.pihet@newoldbits.com>
CC:     Mark Brown <broonie@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-3-jean.pihet@newoldbits.com>
 <2ea31c73-13ee-a51e-e8b7-69cbe3b83c43@ti.com>
 <CAORVsuX10LqQhf8t0x+=xJs2A9pA2eCT2uKUYb4TAhYn08=2ug@mail.gmail.com>
 <eab232c1-b521-6a95-8726-5b70e5842d98@ti.com>
 <CAORVsuWO7RGXUxBZoD-Ww4PE-zPcFCwR1d5yNki02iHot_iOFA@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <305a1e3b-23d9-5179-cfc1-fdeab7591baf@ti.com>
Date:   Tue, 10 Dec 2019 18:09:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAORVsuWO7RGXUxBZoD-Ww4PE-zPcFCwR1d5yNki02iHot_iOFA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 10/12/19 5:40 pm, Jean Pihet wrote:
> Hi Vignesh,
> 
> On Tue, Dec 10, 2019 at 9:40 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>
>> Hi Jean,
>>
>> On 09/12/19 5:12 pm, Jean Pihet wrote:
>>> Hi Vignesh,
>>>
>>> On Mon, Dec 9, 2019 at 11:27 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>>>>
>>>>
>>>>
>>>> On 06/12/19 9:30 pm, Jean Pihet wrote:
>>>>> The TI QSPI IP has limitations:
>>>>> - the MMIO region is 64MB in size
>>>>> - in non-MMIO mode, the transfer can handle 4096 words max.
>>>>>
>>>>> Add support for bigger devices.
>>>>> Use MMIO and DMA transfers below the 64MB boundary, use
>>>>> software generated transfers above.
>>>>
>>>> Could you change the $subject prefix to be "spi: spi-ti-qspi:"
>>>
>>> Yes sure.
>>>
>>>>
>>>>
>>>> [...]
>>>>
>>>>> -574,6 +601,7 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
>>>>>
>>>>>  static const struct spi_controller_mem_ops ti_qspi_mem_ops = {
>>>>>       .exec_op = ti_qspi_exec_mem_op,
>>>>> +     .adjust_op_size = ti_qspi_adjust_op_size,
>>>>>  };
>>>>>
>>>>>  static int ti_qspi_start_transfer_one(struct spi_master *master,
>>>>> @@ -599,12 +627,11 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,
>>>>>       frame_len_words = 0;
>>>>>       list_for_each_entry(t, &m->transfers, transfer_list)
>>>>>               frame_len_words += t->len / (t->bits_per_word >> 3);
>>>>> -     frame_len_words = min_t(unsigned int, frame_len_words, QSPI_FRAME);
>>>>>
>>>>>       /* setup command reg */
>>>>>       qspi->cmd = 0;
>>>>>       qspi->cmd |= QSPI_EN_CS(spi->chip_select);
>>>>> -     qspi->cmd |= QSPI_FLEN(frame_len_words);
>>>>> +     qspi->cmd |= QSPI_FLEN(QSPI_FRAME);
>>>>>
>>>>
>>>> Hmm, change itself is harmless. But what is the motivation behind the
>>>> change?
>>> Indeed this change does not hurt but is required to prevent an invalid
>>> FLEN value.
>>>
>>> Here are the details:
>>> - t->len is in bytes,
>>> - the length passed to qspi_transfer_msg is in bytes,
>>> - frame_len_words is the number of words in the SPI model,
>>> - the words as used by the TI QSPI IP is not the same as
>>> frame_len_words.
>>
>>> In TI QSPI the word size depends on the number of
>>> I/Os i in use (SPI_NBITS_xxx and op->data.buswidth).
>>>
>>
>> How did you get this impression? Word size is independent of number of
>> SPI I/O lines in use. There can be a slave of 32 bit word size on a
>> 1 bit SPI bus (SPI_NBITS_SINGLE).
>>
>> Flash devices have word size of 1 byte (IOW byte addressable)
>> but buswidth can be 1/2/4. A Quad IO flash does not mean word size of 32 bit
>> word size.
> 
> The assumption is that every transfer is based on 8 clock cycles (byte
> addressable) as for the SPI flash and that
> the optimization is about getting the most data bytes from every
> transfer (32 bits in quad I/O, 16 bits in dual, 8 bits in single).
> Is this a valid assumption?
> 

No, data phase does not have be 8 clock cycles long. This is only true
in case of 1 bit mode where 8 clock cycles are required to transfer a
full byte. In case of Quad mode, only 4 clock cycles are enough to
transfer 2 bytes of data with WLEN set to 1 byte (FLEN or number of
words read should be even).

Have you tried setting WLEN = 1 in Quad mode? Did you see any issue with
that configuration?

Regards
Vignesh

>>
>>
>>> For example a quad I/O transfer with t->bits_per_word=8 generates 4
>>> bytes of data every 8 clock cycles.
>>
>>> In this case frame_len_words =
>>> 16384. The maximum of bytes transferred by TI QSPI is 4096 * 4 =
>>> 16384. Setting FLEN to frame_len_words leads to an invalid value (max
>>> value is 0xFFF + 1).
>>>
>>
>> But we have:
>>
>>         list_for_each_entry(t, &m->transfers, transfer_list)
>>                 frame_len_words += t->len / (t->bits_per_word >> 3);
>>
>>         /* Clamps max words to 4096 words */
>>         frame_len_words = min_t(unsigned int, frame_len_words, QSPI_FRAME);
>>
>>         /* setup command reg */
>>         qspi->cmd = 0;
>>         qspi->cmd |= QSPI_EN_CS(spi->chip_select);
>>
>>         /* FLEN field is set to max of 4095 bytes as */
>>         qspi->cmd |= QSPI_FLEN(frame_len_words);
>>
>> So, without changes in patch 3/3, there is no need to set FLEN to be set to 0xFFF.
>> But FLEN needs to be set to even words in case of dual/quad mode as per AM437x TRM
> Correct but in that case the number of bytes received for every
> transfer is not optimum, i.e. 4x more data
> could be transferred in quad I/O.
> 
> The solution is to calculate frame_len_words from the bits_per_word
> and rx_nbits.
> 
> What do you think?
> 
> Thanks & regards,
> Jean
> 
>>
>>> So this changes takes the I/O mode into account by limiting the
>>> maximum number of bytes per frame in ti_qspi_adjust_op_size, by
>>> programming FLEN with the maximum allowed value and by stopping the
>>> transfer when the data is transferred.
>>>
>>> Does this make sense?
>>
>>>
>>> Regards,
>>> Jean
>>>
>>
>> --
>> Regards
>> Vignesh

-- 
Regards
Vignesh
