Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D46215110B
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2020 21:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgBCUdV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Feb 2020 15:33:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgBCUdU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Feb 2020 15:33:20 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013KIeG4082304;
        Mon, 3 Feb 2020 15:33:15 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xxhf74kqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 15:33:14 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 013KJwVV085345;
        Mon, 3 Feb 2020 15:33:14 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xxhf74kq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 15:33:14 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 013KVbGB027428;
        Mon, 3 Feb 2020 20:33:13 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 2xw0y6gpe0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 20:33:13 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 013KXCOU52298216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Feb 2020 20:33:12 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D0C65112067;
        Mon,  3 Feb 2020 20:33:12 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BF94112063;
        Mon,  3 Feb 2020 20:33:12 +0000 (GMT)
Received: from [9.41.103.158] (unknown [9.41.103.158])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  3 Feb 2020 20:33:12 +0000 (GMT)
Subject: Re: [PATCH] spi: Add FSI-attached SPI controller driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Eddie James <eajames@linux.ibm.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
References: <1580328504-436-1-git-send-email-eajames@linux.ibm.com>
 <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Message-ID: <29f6cc86-69ca-bc88-b6ae-2b1a24c0dae3@linux.vnet.ibm.com>
Date:   Mon, 3 Feb 2020 14:33:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeNs9Zr1vayO8TwVq6=B8fwvv0chOt0in6Dw+WLCezL2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_06:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 clxscore=1011 mlxlogscore=999 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002030146
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 1/30/20 10:37 AM, Andy Shevchenko wrote:
> On Wed, Jan 29, 2020 at 10:09 PM Eddie James <eajames@linux.ibm.com> wrote:
>> There exists a set of SPI controllers on some POWER processors that may
>> be accessed through the FSI bus. Add a driver to traverse the FSI CFAM
>> engine that can access and drive the SPI controllers. This driver would
>> typically be used by a baseboard management controller (BMC).
> ...
>
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include <linux/of.h>
> ...
>
>> +struct fsi_spi {
>> +       struct device *dev;
> Isn't fsl->dev the same?
> Perhaps kernel doc to explain the difference?


No, it's not the same, as dev here is the SPI controller. I'll add a 
comment.


>
>> +       struct fsi_device *fsi;
>> +       u32 base;
>> +};
> ...
>
>> +static int fsi_spi_read_reg(struct fsi_spi *ctx, u32 offset, u64 *value)
>> +{
>> +       int rc;
>> +       __be32 cmd_be;
>> +       __be32 data_be;
>> +       *value = 0ULL;
> Usually the pattern is don't pollute output on error condition. Any
> reason why you zeroing output beforehand?


Well otherwise I have to store another 64 bit int and do another 
assignment at the end. This is an internal function and all the users 
below know what's happening.


>
>> +       cmd_be = cpu_to_be32(offset + ctx->base);
>> +       rc = fsi_device_write(ctx->fsi, FSI2SPI_CMD, &cmd_be, sizeof(cmd_be));
>> +       if (rc)
>> +               return rc;
>> +       return 0;
>> +}
> ...
>
>> +       data_be = cpu_to_be32((value >> 32) & 0xFFFFFFFF);
> Redundant & 0xff... part.
>
>> +       data_be = cpu_to_be32(value & 0xFFFFFFFF);
> Ditto.
>
> You may use upper_32_bits() / lower_32_bits() instead.


OK, thanks.


>
> ...
>
>> +static int fsi_spi_data_in(u64 in, u8 *rx, int len)
>> +{
>> +       int i;
>> +       int num_bytes = len > 8 ? 8 : len;
> min(len, 8);


Sure.


>
>> +       for (i = 0; i < num_bytes; ++i)
>> +               rx[i] = (u8)((in >> (8 * ((num_bytes - 1) - i))) & 0xffULL);
> Redundant & 0xffULL part.
>
> Isn't it NIH of get_unalinged_be64 / le64 or something similar?


No, these are shift in/out operations. The read register will also have 
previous operations data in them and must be extracted with only the 
correct number of bytes.


>
>> +       return num_bytes;
>> +}
>> +static int fsi_spi_data_out(u64 *out, const u8 *tx, int len)
>> +{
> Ditto as for above function. (put_unaligned ...)
>
>> +}
> ...
>
>> +       dev_info(ctx->dev, "Resetting SPI controller.\n");
> info?! Why?
>
>> +       rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
>> +                              SPI_FSI_CLOCK_CFG_RESET2);
>> +       return rc;
> return fsi_spi_write_reg();
>
> ...
>
>> +       return ((64 - seq->bit) / 8) - 2;
> Too many parentheses.


I prefer using 2 extra characters to make it much clearer at a glance.


>
> ...
>
>> +static int fsi_spi_sequence_transfer(struct fsi_spi *ctx,
>> +                                    struct fsi_spi_sequence *seq,
>> +                                    struct spi_transfer *transfer)
>> +{
>> +       int loops = 1;
>> +       int idx = 0;
>> +       int rc;
>> +       u8 len;
>> +       u8 rem = 0;
>> +       if (transfer->len > 8) {
>> +               loops = transfer->len / 8;
>> +               rem = transfer->len - (loops * 8);
>> +               len = 8;
>> +       } else {
>> +               len = transfer->len;
>> +       }
> len = min(transfer->len, 8);
>
> loops = transfer->len / len;
> rem = transfer->len % len;


Sure.


>
> (I think compiler is clever enough to find out that the division can be avoided)
>
> ...and drop assignments in definition block.
>
> I didn't look carefully in the implementation, but I believe there is
> still room for improvement / optimization.
>
>> +       if (loops > 1) {
>> +               rc = fsi_spi_write_reg(ctx, SPI_FSI_COUNTER_CFG,
>> +                                      SPI_FSI_COUNTER_CFG_LOOPS(loops - 1));
>> +               if (rc) {
>> +                       /* Ensure error returns < 0 in this case. */
> I didn't get why this case is special? Why not to be consistent with
> return value?


Sure, will fix, this was leftover from some testing.


>
>> +                       if (rc > 0)
>> +                               rc = -rc;
>> +
>> +                       return rc;
>> +               }
>> +               return loops;
> If we return here the amount of loops...
>
>> +       }
>> +
>> +       return 0;
> ...why here is 0?
>
> I think more consistency is required.


Will refactor.


>
>> +}
> ...
>
>> +static int fsi_spi_transfer_data(struct fsi_spi *ctx,
>> +                                struct spi_transfer *transfer)
>> +{
> Can you refactor to tx and rx parts?


Why?


>
>> +       return 0;
>> +}
> ...
>
>> +       do {
>> +               rc = fsi_spi_read_reg(ctx, SPI_FSI_STATUS, &status);
>> +               if (rc)
>> +                       return rc;
>> +
>> +               if (status & (SPI_FSI_STATUS_ANY_ERROR |
>> +                             SPI_FSI_STATUS_TDR_FULL |
>> +                             SPI_FSI_STATUS_RDR_FULL)) {
>> +                       rc = fsi_spi_reset(ctx);
>> +                       if (rc)
>> +                               return rc;
>> +
>> +                       continue;
> I forgot if this to be infinite loop or if it's going to check
> previous seq_state value. In any case this code is a bit fishy. Needs
> comments / refactoring.


I'll add a timeout.


>
>> +               }
>> +
>> +               seq_state = status & SPI_FSI_STATUS_SEQ_STATE;
>> +       } while (seq_state && (seq_state != SPI_FSI_STATUS_SEQ_STATE_IDLE));
> ...
>
>> +       if ((clock_cfg & (SPI_FSI_CLOCK_CFG_MM_ENABLE |
>> +                         SPI_FSI_CLOCK_CFG_ECC_DISABLE |
>> +                         SPI_FSI_CLOCK_CFG_MODE |
>> +                         SPI_FSI_CLOCK_CFG_SCK_RECV_DEL |
>> +                         SPI_FSI_CLOCK_CFG_SCK_DIV)) != wanted_clock_cfg)
>> +               rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
>> +                                      wanted_clock_cfg);
> Missed {} ?


No? It's one line under the if.


>
>> +
>> +       return rc;
>> +}
> ...
>
>> +       rc = fsi_slave_read(fsi->slave, 0x2860, &root_ctrl_8,
> What is this magic for?


Added comment.


>
>> +                           sizeof(root_ctrl_8));
>> +       if (rc)
>> +               return rc;
> ...
>
>> +static int fsi_spi_remove(struct device *dev)
>> +{
>> +       return 0;
>> +}
> Why do you need this?


Will drop it.


Thanks for the review!

Eddie


>
> ...
>
>> +static struct fsi_driver fsi_spi_driver = {
>> +       .id_table = fsi_spi_ids,
>> +       .drv = {
>> +               .name = "spi-fsi",
>> +               .bus = &fsi_bus_type,
> Why is it not in the module_fsi_driver() macro?
>
>> +               .probe = fsi_spi_probe,
>> +               .remove = fsi_spi_remove,
>> +       },
>> +};
>> +
>> +module_fsi_driver(fsi_spi_driver);
