Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC92A7CF5
	for <lists+linux-spi@lfdr.de>; Thu,  5 Nov 2020 12:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgKEL2d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 5 Nov 2020 06:28:33 -0500
Received: from mail-eopbgr1300105.outbound.protection.outlook.com ([40.107.130.105]:21919
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730044AbgKEL1z (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Nov 2020 06:27:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJpUXzxvej0XssepM/KukownbJZIyu8HjOGHeBiXi7fF+3AsYMbq7zm+AwuG19chMrv9ZsyOqk5CLvDX0ClbOeSYL39482aNFNRHU487FkXEhyUDY3R6xYAU9Y222rdW93ZFo+EvM1DX9teBwISgoHkfXERtOE+TdLhj+kGS+tl3eVXp4wbUQ5PEAcmDLDtDbLR81ZkVRsAhhcM70vI74kSkxlxcFSBJZ64OxxKPk1+Kc4LzJ3ag29q4JfFyBuIAA5jJjK6yoCabTS8cFb+dMo7QKKNLLm7QAaWDeCPPn6gVg2Obwg1t3bW4gzCUCUZ9RaKQTpesbPKEtAFATkd6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMpjagL7uCG65TEctWRfhkXE8hxXrSBV6rDOb/wnMHw=;
 b=JEy4lO3uY5k9dl7j2+hfpH1EiYeRA/CsyWyzkiuOZ021jXRfaRb/oE9nOnJx2+qejIGTtb0hLJfTnN10Fo5TbPRgoLZwVhx58oVmhyV01PDAiYea/znJYXmDmw3KjjxQNPXNMj9QjFIyRoJivM2sdVAVcWyWQuM3bLLmFBr27icJMbNxvQa9BS0gN9lYNkz09pCAfD/6CNOFmxOtC3la0pJ6Mu9ezRLcXeM+MyO24gnIKDiYDcvy9yDHtgCsTmz3vYUtHwEcPbrMy61pQ8XkrcfXSXIyLCTMorhAU79qCn5aLm3QM3/pn2WVa0YiQpbiI+yoSOJNVkejXqtJP3Rurg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB2786.apcprd06.prod.outlook.com (2603:1096:203:5b::22)
 by HK0PR06MB2355.apcprd06.prod.outlook.com (2603:1096:203:4c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 5 Nov
 2020 11:27:50 +0000
Received: from HK0PR06MB2786.apcprd06.prod.outlook.com
 ([fe80::c9cf:b4b1:3371:d532]) by HK0PR06MB2786.apcprd06.prod.outlook.com
 ([fe80::c9cf:b4b1:3371:d532%7]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 11:27:50 +0000
From:   Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>, "clg@kaod.org" <clg@kaod.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [v2 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
Thread-Topic: [v2 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller
 driver
Thread-Index: AQHWsbIP1PTypXiLYkKI+HNV4rpdLam4ceqAgAD3iZA=
Date:   Thu, 5 Nov 2020 11:27:49 +0000
Message-ID: <HK0PR06MB2786F899D5591FD0567467D4B2EE0@HK0PR06MB2786.apcprd06.prod.outlook.com>
References: <20201103072202.24705-1-chin-ting_kuo@aspeedtech.com>
 <20201103072202.24705-5-chin-ting_kuo@aspeedtech.com>
 <20201104203955.GA4795@sirena.org.uk>
In-Reply-To: <20201104203955.GA4795@sirena.org.uk>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 082bc930-f596-43f4-6768-08d8817dd402
x-ms-traffictypediagnostic: HK0PR06MB2355:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB235598DEA9DC7CC5E79D83C1B2EE0@HK0PR06MB2355.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:240;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dR+t29SQXBxncAqNNy8YJk7MQ95KujJiF3KLvAasZ2ZmCJcpEisI0H1frT1pZlfqEavRhPRmcGTfg6+D/ma5EV55R3a52/MHEt5xOsJ0VUFXMygvyBdgQnjxQ9NjgAHwomVfjtyklsSb/IrnMN5/t4FJlWdWVQP3+tSRoVmfhrJl/25rjjSHWWXD7fQtlCnoXVUXf/fKQcBF9qeswJI5ufXo7vWdQ94z5zvbY41edBdTobt9pMleVbcdhc6XgGq+szN42MW2Udl74zaaDnHRWvdlp8o8cyLonNPydT7AXbZ2//ALk6c+eJ2NhigC25YVN96VswGycEc4o/0wLdmbXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB2786.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39840400004)(366004)(396003)(66476007)(107886003)(6916009)(66446008)(66556008)(76116006)(2906002)(64756008)(4326008)(5660300002)(66946007)(86362001)(7416002)(55016002)(26005)(33656002)(316002)(186003)(478600001)(54906003)(55236004)(6506007)(8936002)(7696005)(8676002)(53546011)(52536014)(9686003)(71200400001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CPsESnxYt/GU28l2OdJjCOluKQTMYJ/Vn1WQLSRbdWr2jmLtzMgnNXUF8KcSy/gz5K/KQ6NOVXziO1W/LmQJCIaY0SvNbfsl6MT38JB6ZVmgB6MiybN6p03eJvOfskqkokq1ouHM78gpPZz/ao7aYTovSk74SqQVtpZYEtObEaWu1anSD+m73BickmM/fok/N6DQnsRnu/HvJl9WcLmLUXQXh0R/ARZgOH5f45MKQKA9PfK3FrDvCCpybkIJ4JpBpFOBMfO4P3etMaq92UMWInsZ+IKkJ+t/eGO8p7Ekblw+WG6PYdgjNMaYjDVnZAu6RetcwTjpe+c2PadlLtwIZPN1KWck3Sc77ZZy59FBQmEm3XLq0EyGhs0pIeo7/tty+VLTiZttpqp8poz32j02WnwjC8HQ2iNmrf/S+1MGJ3Kp/Mr7xWfTS6aVEQdmE6rX0rT5vNsincbvm4wzgt+vd3ZwvYw9ZaPwR6WIcuKDDDgwKAcHk7xmrv2a2W984lD/6g3scezRe8z4A2qa8g3TATdbkWWJn6LdZ6egawUyuq6HpnGvAeT2Ks82M6VfpD5dWF4TBULyzdnRZ9lb260x27cMQ1UD7/5EacL1/6TuWE9eG5Wr6yJSnvwqmhbeYJKhaCvSnik/41MEB8RbKqScig==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB2786.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082bc930-f596-43f4-6768-08d8817dd402
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 11:27:49.9858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QnHVLrJ+dP5KMd9X1yWRLiSnzdW+HMNRHut56jpwxEr8WEZnU9KHYUrGCWGXLQTvAwMoqfZV5J1HJ2Qf/m7GakmY+/gqfm1IcHCMWz8N+Do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2355
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

Thanks for your comment.

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Thursday, November 5, 2020 4:40 AM
> To: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Cc: robh+dt@kernel.org; joel@jms.id.au; andrew@aj.id.au; clg@kaod.org;
> bbrezillon@kernel.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org; linux-aspeed@lists.ozlabs.org;
> linux-spi@vger.kernel.org; BMC-SW <BMC-SW@aspeedtech.com>
> Subject: Re: [v2 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller
> driver
> 
> On Tue, Nov 03, 2020 at 03:22:02PM +0800, Chin-Ting Kuo wrote:
> > Add driver for ASPEED BMC FMC/SPI memory controller which supports
> > spi-mem interface.
> 
> This breaks the build for me with an x86 allmodconfig:

I will fix these problems on the next patch version.

> 
> /mnt/kernel/drivers/spi/spi-aspeed.c: In function
> 'aspeed_2600_spi_dma_checksum':
> /mnt/kernel/drivers/spi/spi-aspeed.c:195:9: warning: cast from pointer to
> integer of different size [-Wpointer-to-int-cast]
>   writel((uint32_t)ast_ctrl->chips[cs].ahb_base_phy,
>          ^
> /mnt/kernel/drivers/spi/spi-aspeed.c: In function
> 'aspeed_spi_decode_range_config':
> /mnt/kernel/drivers/spi/spi-aspeed.c:488:27: warning: cast to pointer from
> integer of different size [-Wint-to-pointer-cast]
>    chip[cs].ahb_base_phy = (void __iomem *)start_addr_phy;
>                            ^
> In file included from /mnt/kernel/include/linux/printk.h:409,
>                  from /mnt/kernel/include/linux/kernel.h:16,
>                  from /mnt/kernel/include/linux/clk.h:13,
>                  from /mnt/kernel/drivers/spi/spi-aspeed.c:11:
> /mnt/kernel/drivers/spi/spi-aspeed.c: In function 'aspeed_spi_exec_op':
> /mnt/kernel/drivers/spi/spi-aspeed.c:619:44: warning: cast from pointer to
> integer of different size [-Wpointer-to-int-cast]
>    ctrl_val, addr_mode_reg, addr_data_mask, (uint32_t)op_addr);
>                                             ^
> /mnt/kernel/include/linux/dynamic_debug.h:129:15: note: in definition of
> macro '__dynamic_func_call'
>    func(&id, ##__VA_ARGS__);  \
>                ^~~~~~~~~~~
> /mnt/kernel/include/linux/dynamic_debug.h:161:2: note: in expansion of
> macro '_dynamic_func_call'
>   _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
>   ^~~~~~~~~~~~~~~~~~
> /mnt/kernel/include/linux/dev_printk.h:123:2: note: in expansion of macro
> 'dynamic_dev_dbg'
>   dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~
> /mnt/kernel/drivers/spi/spi-aspeed.c:618:2: note: in expansion of macro
> 'dev_dbg'
>   dev_dbg(dev, "ctrl: 0x%08x, addr_mode: 0x%x, mask: 0x%x, addr:0x%08x\n",
>   ^~~~~~~
> /mnt/kernel/drivers/spi/spi-aspeed.c: In function 'aspeed_spi_dirmap_read':
> /mnt/kernel/drivers/spi/spi-aspeed.c:651:25: warning: format '%x' expects
> argument of type 'unsigned int', but argument 6 has type 'size_t' {aka 'long
> unsigned int'} [-Wformat=]
>   dev_dbg(ast_ctrl->dev, "read op:0x%x, addr:0x%llx, len:0x%x\n",
>                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /mnt/kernel/include/linux/dynamic_debug.h:129:15: note: in definition of
> macro '__dynamic_func_call'
>    func(&id, ##__VA_ARGS__);  \
>                ^~~~~~~~~~~
> /mnt/kernel/include/linux/dynamic_debug.h:161:2: note: in expansion of
> macro '_dynamic_func_call'
>   _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
>   ^~~~~~~~~~~~~~~~~~
> /mnt/kernel/include/linux/dev_printk.h:123:2: note: in expansion of macro
> 'dynamic_dev_dbg'
>   dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~
> /mnt/kernel/include/linux/dev_printk.h:123:23: note: in expansion of macro
> 'dev_fmt'
>   dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                        ^~~~~~~
> /mnt/kernel/drivers/spi/spi-aspeed.c:651:2: note: in expansion of macro
> 'dev_dbg'
>   dev_dbg(ast_ctrl->dev, "read op:0x%x, addr:0x%llx, len:0x%x\n",
>   ^~~~~~~
> /mnt/kernel/drivers/spi/spi-aspeed.c: In function 'aspeed_spi_dirmap_write':
> /mnt/kernel/drivers/spi/spi-aspeed.c:676:25: warning: format '%x' expects
> argument of type 'unsigned int', but argument 6 has type 'size_t' {aka 'long
> unsigned int'} [-Wformat=]
>   dev_dbg(ast_ctrl->dev, "write op:0x%x, addr:0x%llx, len:0x%x\n",
> 
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /mnt/kernel/include/linux/dynamic_debug.h:129:15: note: in definition of
> macro '__dynamic_func_call'
>    func(&id, ##__VA_ARGS__);  \
>                ^~~~~~~~~~~
> /mnt/kernel/include/linux/dynamic_debug.h:161:2: note: in expansion of
> macro '_dynamic_func_call'
>   _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
>   ^~~~~~~~~~~~~~~~~~
> /mnt/kernel/include/linux/dev_printk.h:123:2: note: in expansion of macro
> 'dynamic_dev_dbg'
>   dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>   ^~~~~~~~~~~~~~~
> /mnt/kernel/include/linux/dev_printk.h:123:23: note: in expansion of macro
> 'dev_fmt'
>   dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
>                        ^~~~~~~
> /mnt/kernel/drivers/spi/spi-aspeed.c:676:2: note: in expansion of macro
> 'dev_dbg'
>   dev_dbg(ast_ctrl->dev, "write op:0x%x, addr:0x%llx, len:0x%x\n",
>   ^~~~~~~
> /mnt/kernel/drivers/spi/spi-aspeed.c: At top level:
> /mnt/kernel/drivers/spi/spi-aspeed.c:820:17: error: initialization of 'ssize_t
> (*)(struct spi_mem_dirmap_desc *, u64,  size_t,  void *)' {aka 'long int
> (*)(struct spi_mem_dirmap_desc *, long long unsigned int,  long unsigned int,
> void *)'} from incompatible pointer type 'int (*)(struct spi_mem_dirmap_desc
> *, uint64_t,  size_t,  void *)' {aka 'int (*)(struct spi_mem_dirmap_desc *,
> long long unsigned int,  long unsigned int,  void *)'}
> [-Werror=incompatible-pointer-types]
>   .dirmap_read = aspeed_spi_dirmap_read,
>                  ^~~~~~~~~~~~~~~~~~~~~~
> /mnt/kernel/drivers/spi/spi-aspeed.c:820:17: note: (near initialization for
> 'aspeed_spi_mem_ops.dirmap_read')
> /mnt/kernel/drivers/spi/spi-aspeed.c:821:18: error: initialization of 'ssize_t
> (*)(struct spi_mem_dirmap_desc *, u64,  size_t,  const void *)' {aka 'long int
> (*)(struct spi_mem_dirmap_desc *, long long unsigned int,  long unsigned int,
> const void *)'} from incompatible pointer type 'int (*)(struct
> spi_mem_dirmap_desc *, uint64_t,  size_t,  const void *)' {aka 'int (*)(struct
> spi_mem_dirmap_desc *, long long unsigned int,  long unsigned int,  const
> void *)'} [-Werror=incompatible-pointer-types]
>   .dirmap_write = aspeed_spi_dirmap_write,
>                   ^~~~~~~~~~~~~~~~~~~~~~~
> /mnt/kernel/drivers/spi/spi-aspeed.c:821:18: note: (near initialization for
> 'aspeed_spi_mem_ops.dirmap_write')
> cc1: some warnings being treated as errors
